

def Input_Segartion(data):
    
    if data.isalpha()==False:
        l2 = data.replace(',', '')
        print(l2)
        l3 = l2.split()
        l1=int(l3[0][1:])
        print(l1)
        return l1
    else:
        pass
    
        
        
s=Input_Segartion('$34,235')
        

        