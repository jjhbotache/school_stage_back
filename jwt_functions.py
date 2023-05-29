from jwt import encode,decode


password = "sErVeRpazzw0rd"

def create_tk(data:dict):
  return encode(
    payload={**data},
    key=password
    )
  
def validate_tk(token):
  try:
    decoded_info = decode(token,password,("HS256"))
    return decoded_info
  except Exception as e:
    print(token)
    print(e)
    return False
  
def validate_user_tk(token,user_ids_list:list):
  try:
    data = decode(token,password,("HS256"))
    print(user_ids_list)
    if int(data["id"]) in user_ids_list:
      return data
    else:
      return False
    # return True
  except Exception as e:
    print(token)
    print(e)
    return False