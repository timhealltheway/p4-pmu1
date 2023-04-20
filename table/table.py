import math

# result = 5
cos_res =[]
sin_res =[]

def generate_cos_function():
  for degree in range(0,30):
      cos_val = int((math.cos(math.radians(degree))) * 1000)
      function_def = f"action set_cos_{degree}_result(){{result = {cos_val}; }}"
      index_fun = f"    {degree}: set_cos_{degree}_result;"
      set_fun = f"set_cos_{degree}_result;"
      for multiplier in range(95,101):
          result = cos_val * multiplier
          cos_res.append(result);
      # print(function_def)
      # print(index_fun)
      # print(set_fun)

def generate_sin_function():
  for degree in range(0,30):
      sin_val = int((math.sin(math.radians(degree))) * 1000)
      function_def = f"action set_sin_{degree}_result(){{result = {sin_val}; }}"
      index_fun = f"    {degree}: set_sin_{degree}_result;"
      set_fun = f"set_sin_{degree}_result;"
      for multiplier in range(95,101):
            result = sin_val * multiplier
            sin_res.append(result);
      # print(function_def)
      # print(index_fun)
      # print(set_fun)

def jpt(lst,res):
    measurements =[]
    for i in range(len(lst)):
        for j in range(i +1, len(lst)):
            for k in range(j+1,len(lst)):
                kMin1 = lst[i]
                kMin2 = lst[j]
                kMin3 = lst[k]
                measurement = 3 * kMin1 - 3 * kMin2 + kMin3;
                measurements.append(measurement)
                res.append(measurement)

def div(lst1,lst2,res):
    with open("arcTan_third","w") as file: #arcTan_output.txt # arcTan_second #
        # output_line1 = f"action set_arctan_0_result(){{result = 0; }}\n"
        # file.write(output_line1)
        arctan_res =[]
        for i in range(0,100):
            for j in range(0,100):
                a = lst1[i]
                b = lst2[j]
                x = (a/b)
                res.append(x)
                rad = math.atan(x);

                d = int(rad * 1000)
                int_deg =int(math.degrees(rad))
                print("img",a,",real",b,",arctan_rad_val",int(rad * 1000),",rad to degree",int(math.degrees(rad)),'\n')

                if(d not in arctan_res):
                    arctan_res.append(d);
                    output_line2 = f"action set_arctan_{d}_result(){{result = {int_deg}; }}\n"
                    output_line3 = f"{d} : set_arctan_{d}_result; \n"
                    output_line4 = f"set_arctan_{d}_result; \n"
                    file.write(output_line4)

def divByone(lst1,lst2,res):
    oneDivRes =[]
    with open("div_third.txt","w") as file: #div_first.txt #div_second.txt
        for i in range(0,5):
            for j in range(0,600):
                a = 10000000
                b = lst2[j]
                x = int(a/b)
                print("real",b,"res",x);
                print(len(lst2));
                if(b not in oneDivRes):
                    oneDivRes.append(b);
                    output_line1 = f"action set_one_div_{b}(){{result = {x};}} \n"
                    output_line2 = f"{b} : set_one_div_{b}; \n"
                    output_line3 = f"set_one_div_{b}; \n"
                    file.write(output_line3)




generate_cos_function()
generate_sin_function()
res =[]
img =[]
real =[]
jpt(cos_res,real)
jpt(sin_res,img)
# print("img",img,'\n')
# print("real",real,'\n')
# div(img,real,res)
divByone(img,real,res)
