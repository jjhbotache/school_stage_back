from flask import Flask,jsonify,request,send_file,redirect
import pymysql
import os
import re
from flask_cors import CORS
from send_mail import *
from jwt_functions import *
from functools import wraps
import random
import csv
import sqlite3
from helper_fuctions import *
# from waitress import serve



#------------
# locker decorator
def locked_route(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        # get the password of the user with some id
        conn = Data_base()
        password = validate_tk(request.headers["auth"])["password"]
        # password = conn.read("users",["password"],f"id = {user_id} ")[0]["password"]
        if password :
            return func(*args, **kwargs)
        else:
            raise Exception
    return wrapper

# locker decorator for users
def locked_route_for_anyone(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        conn = Data_base()
        user_list = [row["id"] for row in  conn.read("users",["id"])]
        token = request.headers["auth"]
        isValid = validate_user_tk(token,user_list)
        if isValid:
            return func(*args, **kwargs)
        else:
            raise Exception
    return wrapper

#------------

app = Flask(__name__)

CORS(app)

# database data
# Server: sql10.freemysqlhosting.net
# Name: sql10612108
# Username: sql10612108
# Password: CeU5TeAVxP
# Port number: 3306

class Data_base:
    def __init__(self):
        self.connection = pymysql.connect(
            # host="localhost",
            # user="root",
            # password="J1234567890j",
            # database="school_stage_project"  
            
            host="sql107.epizy.com",
            user="epiz_34329071",
            password="J1234567890j",
            database="epiz_34329071_memorable_db"  
        )
        self.cursor = self.connection.cursor()
        
    def save_design(self,name,img_route,ai_route):
        try:
            self.cursor.execute(f"""
                                INSERT INTO designs(name,img,ai)
                                VALUES(
                                    "{name}",
                                    "{img_route}",
                                    "{ai_route}"
                                )
                                """)
            self.connection.commit()
            return True
        except Exception as e:
          print('An exception occurred: ',e)
          return False
        
    def save_real_design(self,name,img_route,dxf_route):
        try:
            self.cursor.execute(f"""
                                INSERT INTO real_designs(name,img,dxf)
                                VALUES(
                                    "{name}",
                                    "{img_route}",
                                    "{dxf_route}"
                                )
                                """)
            self.connection.commit()
            return True
        except Exception as e:
          print('An exception occurred: ',e)
          return False
        
    def get_all_designs(self):
        try:
            self.cursor.execute(f"""
                                SELECT name,img,ai,id FROM designs
                                """)
            data = self.cursor.fetchall()
            print(data)
            formated_data = []
            os.system("cls")
            for row in data:
                formated_data.append(
                    {
                        "name":row[0],
                        "img_url":row[1],
                        "ai_url":row[2],
                        "id": row[3],
                    }
                )
            return formated_data
        except Exception as e:
            print('An exception occurred: ',e)
            return False
      
    def get_all_real_designs(self):
        try:
            self.cursor.execute(f"""
                                SELECT name,img,dxf,id FROM real_designs
                                """)
            data = self.cursor.fetchall()
            print(data)
            formated_data = []
            os.system("cls")
            for row in data:
                formated_data.append(
                    {
                        "name":row[0],
                        "img_url":row[1],
                        "dxf_url":row[2],
                        "id": row[3],
                    }
                )
            return formated_data
        except Exception as e:
            print('An exception occurred: ',e)
            return False
      
    def update_design(self,id,field,new_data):
        assert field in ["name","img","ai"]
        self.cursor.execute(f"""
                            UPDATE designs
                            SET {field} = {new_data}
                            WHERE id = {id}
                            """)
        self.connection.commit()
 
    def update_real_design(self,id,field,new_data):
        assert field in ["name","img","dxf"]
        self.cursor.execute(f"""
                            UPDATE real_designs
                            SET {field} = {new_data}
                            WHERE id = {id}
                            """)
        self.connection.commit()
 
    def delete_design(self,id):
        self.cursor.execute(f"""
                            DELETE FROM designs
                            WHERE id = {id}
                            """)
        self.connection.commit()
        
    def delete_real_design(self,id):
        self.cursor.execute(f"""
                            DELETE FROM real_designs
                            WHERE id = {id}
                            """)
        self.connection.commit()

    #CRUD
    
    def create(self, table, data:dict):
        
        columns = data.keys()
        query = f"INSERT INTO {table} ({', '.join(columns)}) VALUES ("
        for column in columns:
            try:
                query += data[column]+", "
            except:
                query += str(data[column])+", "
        
        query = query[:-2]+")"
        
        print(query)
        self.cursor.execute(query)
        self.connection.commit()

    def read(self, table, columns=[], where=None):
        columns = ', '.join(columns) if len(columns) > 0 else "*"
        query = f"SELECT {columns} FROM {table}"
        if where:   
            query += f" WHERE {where}"
        print(query)
        self.cursor.execute(query)
        result = self.cursor.fetchall()
        
        column_names = [desc[0] for desc in self.cursor.description] 
        
               
        result_dicts=[]
        for row in result:
            row_dict = { column_names[i]:row[i] for i in range(len(row))}
            result_dicts.append(row_dict)
        
        return result_dicts  

    def update(self, table, data: dict, where):
        # get columns and values from data dictionary
        columns = list(data.keys())
        values = list(data.values())

        # create the SET clause for the update query using a loop
        set_clause = ""
        for i in range(len(columns)):
            set_clause += f"{columns[i]} = {values[i]}"
            if i < len(columns) - 1:
                set_clause += ", "

        # create the update query using the SET clause and WHERE condition
        query = f"UPDATE {table} SET {set_clause} WHERE {where}"
        print(query)

        # execute the update query and commit the changes
        self.cursor.execute(query)
        self.connection.commit()

        # return the number of affected rows
        return self.cursor.rowcount

    def delete(self, table, where):
        query = f"DELETE FROM {table} WHERE {where}"
        self.cursor.execute(query)
        self.connection.commit()
        return self.cursor.rowcount

# ----------------------------------------------------------------------------------------
# designs
@app.route("/design", methods=["POST"])
@locked_route
def save_design():
    name = request.form["name"]
    files_name = request.form["filesName"]
    img = request.files["img"]
    ai = request.files["ai"]
    print("name: ",name)

    route_img = f"img/{files_name}.png"
    route_ai = f"ai/{files_name}.ai"

    if os.path.isfile(route_ai) or os.path.isfile(route_img):
        return f"file with name {name} already exist"
    else:
        try:
            img.save(route_img)
            ai.save(route_ai)
            connection = Data_base()
            connection.save_design(
                name,
                route_img,
                route_ai
            )
            return "Saved succesfully"
        except Exception as e:
            return f"Something went wrong {e}"

@app.route("/real_design", methods=["POST"])
@locked_route
def save_real_design():
    name = request.form["name"]
    files_name = request.form["filesName"]
    img = request.files["img"]
    dxf = request.files["dxf"]
    print("name: ",name)
    print("files_name: ",files_name)

    route_img = f"img/{files_name}.png"
    route_dxf = f"dxf/{files_name}.dxf"

    if os.path.isfile(route_dxf) or os.path.isfile(route_img):
        return f"file with name {name} already exist"
    else:
        try:
            img.save(route_img)
            dxf.save(route_dxf)
            connection = Data_base()
            connection.save_real_design(
                name,
                route_img,
                route_dxf
            )
            return "Saved succesfully"
        except Exception as e:
            return f"Something went wrong {e}"

@app.route("/design", methods=["GET"])
def get_designs():
    connection = Data_base()
    return jsonify(connection.get_all_designs())      
        
@app.route("/update_design/<int:id>/<string:field>", methods=["POST"])
@locked_route
def update_design(id,field):
    if field == "name":
        data = request.get_json()["new_data"]
        conn = Data_base()
        conn.update_design(id,field,data)
        
    if field == "img":
        print("changing img")
        conn = Data_base()
        designs = conn.get_all_designs()
        route_img = list(filter(lambda design : design["id"]==id, designs))[0]["img_url"]
        print("changing the img at ",route_img)
        
        img = request.files["img"]
        os.remove(route_img)
        img.save(route_img)
    
    if field == "ai":
        print("changing img")
        conn = Data_base()
        designs = conn.get_all_designs()
        route_ai = list(filter(lambda design : design["id"]==id, designs))[0]["ai_url"]
        ai = request.files["ai"]
        os.remove(route_ai)
        ai.save(route_ai)
    # try:
    #     return jsonify({"msg":"updated succesfully"})    
    # except Exception as e:
    #     return jsonify({"msg":f"An exception occurred: {e}"})
    
@app.route("/update_real_design/<int:id>/<string:field>", methods=["POST"])
@locked_route
def update_real_design(id,field):
    if field == "name":
        data = request.get_json()["new_data"]
        conn = Data_base()
        conn.update_real_design(id,field,data)
        
    if field == "img":
        print("changing img")
        conn = Data_base()
        designs = conn.get_all_real_designs()
        route_img = list(filter(lambda design : design["id"]==id, designs))[0]["img_url"]
        print("changing the img at ",route_img)
        img = request.files["img"]
        print("REMOVING")
        os.remove(route_img)
        print("SAVING")
        img.save(route_img)
        
    if field == "dxf":
        print("changing img")
        conn = Data_base()
        designs = conn.get_all_real_designs()
        route_dxf = list(filter(lambda design : design["id"]==id, designs))[0]["dxf_url"]
        dxf = request.files["dxf"]
        print("REMOVING DXF")
        os.remove(route_dxf)
        print("SAVING DXF")
        dxf.save(route_dxf)
  
    return jsonify({"msg":"updated succesfully"})    
    
@app.route("/delete_design/<int:id>", methods=["DELETE"])
@locked_route
def delete_design(id):
    try:
        print(f"DELETING design with id: {id}")
        conn = Data_base()
        designs = conn.get_all_designs()
        design = list(filter(lambda design : design["id"]==id, designs))[0]
        route_ai=design["ai_url"]
        route_img=design["img_url"]
        conn.delete_design(id)
        os.remove(route_ai)
        os.remove(route_img)
        
        return jsonify({"msg":"deleted succesfully"})
    
    except Exception as e:
        print(e)
        return jsonify({"msg":f"An exception occurred: {e}"})
      
@app.route("/delete_real_design/<int:id>", methods=["DELETE"])
@locked_route
def delete_real_design(id):
    try:
        print(f"DELETING real design with id: {id}")
        conn = Data_base()
        designs = conn.get_all_real_designs()
        design = list(filter(lambda design : design["id"]==id, designs))[0]
        route_dxf=design["dxf_url"]
        route_img=design["img_url"]
        conn.delete_real_design(id)
        os.remove(route_dxf)
        os.remove(route_img)
        
        return jsonify({"msg":"deleted succesfully"})
    
    except Exception as e:
        print(e)
        return jsonify({"msg":f"An exception occurred: {e}"})
      
# ----------------------------------------------------------------------------------------
# pucharse orders   
@app.route("/create/pucharse_orders", methods=["POST"])
@locked_route
def create_pucharse_orders():
    conn = Data_base()
    # print the request form and files
    print(request.form)
    print(request.files)
    
    user_id = request.form["user_id"]
    wine_id = request.form["wine_id"]
    real_design_id = request.form["real_design_id"]
    amount = request.form["amount"]
    msg = request.form["msg"]
    primary_color_id = request.form["primary_color_id"]
    secondary_color_id = request.form["secondary_color_id"]
    delivery_date = request.form["delivery_date"]
    address = request.form["address"]
    vaucher = request.files["vaucher"]
    truly_paid = request.form["truly_paid"]
    
    # save vaucher in a folder if it isn't a string
    if type(vaucher) != str:
        vaucher_route = f"vaucher/{vaucher.filename}"
        # if the file doesn't exist, save it
        if not os.path.isfile(vaucher_route):
            vaucher.save(vaucher_route)
        else:
            raise Exception
        
    
    
    query = f"""
    INSERT INTO pucharse_orders(
    id_user,
    id_wine,
    id_real_design,
    msg,
    id_packing_color,
    id_secondary_packing_color,
    delivery_date,
    id_delivery_place,
    id_vaucher,
    amount,
    paid
    )
    VALUES(
    {user_id},
    {wine_id},
    {real_design_id},
    "{msg}",
    {primary_color_id},
    {secondary_color_id},
    "{delivery_date}",
    "{address}",
    "{vaucher_route}",
    {amount},
    {truly_paid}
    );
    """
    print(query)
    conn.cursor.execute(query)
    conn.connection.commit()
    return jsonify({"msg":"Created successfully"})
    
@app.route("/update_pucharse_orders/<string:id>", methods=["PUT"])
@locked_route
def update_pucharse_orders(id):
    conn = Data_base()
    # print the request form and files
    print(request.form)
    print(request.files)
    
    user_id = request.form["user_id"]
    wine_id = request.form["wine_id"]
    real_design_id = request.form["real_design_id"] or 0
    amount = request.form["amount"]
    msg = request.form["msg"]
    primary_color_id = request.form["primary_color_id"]
    secondary_color_id = request.form["secondary_color_id"]
    delivery_date = request.form["delivery_date"]
    address = request.form["address"]
    oldVaucher = request.form["oldVaucher"]
    
    try:vaucher = request.files["vaucher"]
    except:vaucher = request.form["vaucher"]
    
    truly_paid = request.form["truly_paid"]
    
    # save vaucher in a folder if it isn't a string
    if type(vaucher) != str:
        # delete the old vaucher
        os.remove(oldVaucher)       
        vaucher_route = f"vaucher/{vaucher.filename}"
        # if the file doesn't exist, save it
        if not os.path.isfile(vaucher_route):
            vaucher.save(vaucher_route)
        else:
            return jsonify({"msg":"file already exist"},status=500)
    else:
      vaucher_route = vaucher
        
    
    
    query = f"""
    UPDATE pucharse_orders
    SET id_user = {user_id},
        id_wine = {wine_id},
        id_real_design = {real_design_id},
        msg = "{msg}",
        id_packing_color = {primary_color_id},
        id_secondary_packing_color = {secondary_color_id},
        delivery_date = "{delivery_date}",
        id_delivery_place = "{address}",
        id_vaucher = "{vaucher_route}",
        amount = {amount},
        paid = {truly_paid}
    WHERE id = {id};
    """
    print(query)
    
    conn.cursor.execute(query)

    conn.connection.commit()
    # Save the image file to the server
    # vaucher.save(os.path.join(app.config["UPLOAD_FOLDER"], vaucher.filename))
    return jsonify({"msg":"Created successfully"})
    
@app.route("/erase/pucharse_orders/<string:id>", methods=["DELETE"])
@locked_route
def delete_pucharse_orders(id):
    conn = Data_base()
    # get the vaucher route
    vaucher_route = conn.read("pucharse_orders",["id_vaucher"],f"id = {id}")[0]["id_vaucher"]
    
    try:os.remove(vaucher_route)
    except:print('An exception occurred')
    
    conn.delete("pucharse_orders",f'id={id}')
    
    return jsonify({"msg":"delete successfully"})
    
@app.route("/read_pucharse_orders")
@locked_route_for_anyone
def read_pucharse_orders():
    user_id = int(validate_tk(request.headers["auth"])["id"])
    print(user_id)
    conn = Data_base()
    return jsonify(conn.read("pucharse_orders",[],f"id_user = {user_id}"))
      
@app.route("/<string:kind>/<string:name>/<string:token>")
# it's locked just for Ai files
def get_file(kind,name,token):
    route = f"{kind}/{name}"
    if kind == "img":
        return send_file(route, mimetype='image/png')
    elif     kind == "ai"\
        or   kind == "dxf"\
        or   kind == "vaucher":  
            if validate_tk(token): return send_file(route)

# ----------------------------------------------------------------------------------------
# users & admin
# @app.route("/get_admin", methods=["POST"])
# def get_admin():
#     try:
#         print(f"getting admin ",request.get_json()["id"])
#         credentials = request.get_json()
#         print(credentials)
#         conn = Data_base()
#         result = conn.read(
#                 "admins",
#                 ["id_user_admin"],
#                 f"id_user_admin={credentials['id']}"
#             )[0][0] 
        
#         return jsonify({"admin":result,})
    
#     except Exception as e:
#         return jsonify({"msg":f"An exception occurred: {e}"})
      
@app.route("/get_user", methods=["POST"])
def get_user():
    print(f"getting user ",request.get_json()["id"])
    credentials = request.get_json()
    print(credentials)
    conn = Data_base()
    result = conn.read(
            "users",
            [], #all
            f"id={credentials['id']} AND phone = {credentials['phone']}"
        )[0]
    print(result)
    # if the password has anything, send just an empty string
    print(result["password"])
    if result["password"] != None: result["password"] = "-"
    
    return jsonify(result)
    
      
@app.route("/add_user", methods=["POST"])
def add_user():
    try:
        print(f"adding user ",request.get_json()["first_name"])
        info = request.get_json()
        print(info)
        conn = Data_base()
        result = conn.create(
                "users",
                info
            )
        
        return jsonify(
            {
                "result":result,
            }
        )
    
    except Exception as e:
        return jsonify({"msg":f"An exception occurred: {e}"})
  
#============== security

@app.route("/verify/<string:id>",methods=["POST"])
def createTk(id):
    conn = Data_base()
    password = request.get_json()["password"]
    print(password)
    print("id: ",id)
    if password == (conn.read("users",["password"],f"id = {id} ")[0]["password"]):
        
        token_obj = create_tk({"password":password})
        print(token_obj)
        print(type(token_obj))
        return jsonify({"tk":token_obj})
    else:
        raise Exception
        # return jsonify({"msg":"no exists"})
    
@app.route("/test")
@locked_route
def validateTk():
    return jsonify({"msg":"token veified"})
    
@app.route("/verify-user/<string:email>/<string:id>")
def send_user_code(email,id):

    # create a random code of 4 digits and save
    code = random.randint(1000,9999)
    conn = sqlite3.connect('codes.db');c = conn.cursor();c.execute(f"INSERT INTO codes VALUES ('{id}','{code}')");conn.commit();conn.close()
    
    # send the code to the email
    send_mail(email,str(code),f"ur code is: {code}")

    conn = Data_base()
    id = conn.read("users",["id"],f"email = '{email}'")[0]["id"]
    print(id)
    # connect with a sqlite3 db
    
    return jsonify({"msg":"email sended"})
    
@app.route("/test-user/<string:code>/<string:id>")
def validateUser(code,id):
    # connect to codes  sqlite3 database
    conn = sqlite3.connect('codes.db')
    c = conn.cursor()
    # get the id of the user
    print("code recived: ",code)
    gotten_id = c.execute(f"SELECT id FROM codes WHERE code = '{code}'").fetchall()[0][0]
    print(gotten_id)
    if id != gotten_id : raise Exception
    
    # delete the register
    c.execute(f"DELETE FROM codes WHERE id = '{id}'")
    conn.commit()
    conn.close()
    # create a token with the id
    token_obj = create_tk({"id":id})
    print("im giving the tk: ",token_obj)
    return jsonify({"token":token_obj})
    
# ----------------------------------------------------------------------------------------
# routes for users
# make a route that update a row
@app.route("/user/update",methods=["PUT"])
@locked_route_for_anyone
def update_user():
    id = decode(request.headers["auth"],password,("HS256"))["id"]
    conn = Data_base()
    data = request.get_json()
    # get the key the values
    if not "email" in data:
        conn.update("users",data,f'id={id}')
    else:
        print(data)
        id2 = decode(data["newEmailToken"],password,("HS256"))["id"]
        del data["newEmailToken"]
        print("id2: ",id2)
        conn.update("users",data,f'id={id2}')
    return jsonify({"msg":"updated successfully"})

@app.route("/user/read/<string:table>/<int:id>")
@locked_route_for_anyone
def read_user(table,id):
    # return jsonify({"msg":"not working endpoint yet"})
    allowed_tables=[
        "real_designs",
    ]
    
    # id = decode(request.headers["auth"],password,("HS256"))["id"]
    conn = Data_base()
    # get the key the values
    if table in allowed_tables:
        return jsonify(conn.read(table,[],f'id={id}'))
    else:
      raise Exception

@app.route("/user/create/<string:table>",methods=["POST"])
@locked_route_for_anyone
def insert_user(table):
    # id = decode(request.headers["auth"],password,("HS256"))["id"]
    conn = Data_base()
    data = request.get_json()

    allowed_tables = [
        "pucharse_orders"
    ]
    if table in allowed_tables:
        if table == "pucharse_orders":
            # get the actual date and add it 4 able days
            data["delivery_date"] = "'"+add_business_days(4)+"'"
            
            conn.create(table,data)
        else:
            conn.create(table,data)
        return jsonify({"msg":f"created succesfully"})
    else:
      raise Exception
    
# @app.route("/user/delete/<string:table>/<int:id>",methods=["DELETE"])
# @locked_route_for_anyone
# def delete_user(table,id):
#     # id = decode(request.headers["auth"],password,("HS256"))["id"]
#     allowed_tables = [
#         "vouchers"
#     ]
#     if table in allowed_tables:
#         conn = Data_base()
#         if table == "vouchers":
#             route = conn.read(table,["route"],f'id={id}')[0]["route"]
#             os.remove(route)
#             conn.delete(table,f'id={id}')
#         else:
#             conn.delete(table,f'id={id}')
#             return jsonify({"msg":"deleted successfully"})
#     else:
#       raise Exception
 
@app.route("/delete-voucher-file/<string:route>",methods=["DELETE"])
@locked_route_for_anyone
def delete_voucher(route):
    os.remove(route)
    return jsonify({"msg":"deleted successfully"})
 


# ----------------------------------------------------------------------------------------
# general managment
@app.route("/insert/<string:table>",methods=["POST"])
@locked_route
def insert(table):
    conn = Data_base()
    data = request.get_json()
    conn.create(table,data)
    return jsonify({"msg":f"created succesfully"})

@app.route("/read/<string:table>")
@locked_route
def read(table):
    conn = Data_base()
    return jsonify(conn.read(table))
 
@app.route("/update/<string:table>/<int:id>",methods=["PUT"])
@locked_route
def update(table,id):
    conn = Data_base()
    data = request.get_json()
            
    print(data)
    conn.update(table,data,f'id={id}')
    return jsonify({"msg":"updated successfully"})
 
@app.route("/delete/<string:table>/<int:id>",methods=["DELETE"])
@locked_route
def delete(table,id):
    conn = Data_base()
    conn.delete(table,f'id={id}')
    return jsonify({"msg":"deleted successfully"})
 
# ----------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------
# open routes
@app.route("/read-anyone/<string:table>")
def read_for_anyone(table):
    allowed_tables=[
        "wine_kinds",
        "packing_colors",
        "secondary_packing_colors",
        "designs",
    ]
    if table in allowed_tables:
        conn = Data_base()
        return jsonify(conn.read(table))
    else:
        raise  Exception
    
@app.route("/insert-anyone/<string:table>",methods=["POST"])
def insert_for_everyone(table):
    allowed_tables=[
        # "pucharse_orders"
    ]
    if table in allowed_tables:
        conn = Data_base()
        data = request.get_json()
        conn.create(table,data)
        return jsonify({"msg":f"created succesfully"})
    else:
        raise  Exception
    
@app.route("/insert-vaucher-anyone",methods=["POST"])
def insert_vaucher_for_everyone():
    # get the file from a form
    vaucher = request.files["vaucher"]
    # save the file in a folder
    vaucher_route = f"vaucher/{vaucher.filename}"
    if not os.path.isfile(vaucher_route):vaucher.save(vaucher_route)
    else:raise Exception
    # return the route
    
    return jsonify({"vaucher_route":vaucher_route})

@app.route("/pick-up-adress")
def get_pick_up_adress():
    # read from a csv the first line and return it as a json msg
    try:
        print("first way to get dir")
        with open('csv\pick_up_adress.csv', newline='') as csvfile:
            reader = csv.reader(csvfile)
            for row in reader:
                print("row: ",row)
                return jsonify(row)
    except:
        print("second way to get dir")
        with open('csv/pick_up_adress.csv', newline='') as csvfile:
            reader = csv.reader(csvfile)
            for row in reader:
                print("row: ",row)
                return jsonify(row)
    return jsonify({"msg":"no adress found"})

    

if __name__ == "__main__":
    app.run()

# if __name__ == '__main__':
#     from waitress import serve
#     serve(app, host='0.0.0.0', port=1000)