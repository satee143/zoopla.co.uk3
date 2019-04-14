*** Settings ***
Library    SeleniumLibrary   
Library    Collections   
Library    ../Utils/utils.py     
Resource    ../Utils/utils.robot


*** Variables ***
${Location_Textbox_Id}    id:search-input-location
${Search_Button_Id}       id:search-submit
${Retrive_Data_Xpath}     xpath://li[starts-with(@class,"srp")]
${Prop_Value_Xpath}       xpath:(//li[@id]//a[@class="listing-results-price text-price"])
${Selece_Property_Xpath}  xpath:(//li[@id]/div/div[2]/h2/a)[6]
${Prop_Name_Xpath}        xpath://*[@class="ui-property-summary__title ui-title-subgroup"]
${Owner_Name_Xpath}       xpath://h4[@class="ui-agent__name"]
${Property_Link_Xpath}     xpath:(//*[@id]/div/div[2]/h2/a)[1]


*** Keywords ***
Browser Launch
       
    [Documentation]    This is Opening URL in  Browser 
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    
Browser Close
    [Documentation]    Closing the   Browser 
    Close Browser
    
    
#### ENTERING SEARCH LOCATION IN SEARCH BOC ####   
Entering Search Location
    [Documentation]    Location Name is Entering in the Search Box 
    Clear Element Text    ${Location_Textbox_Id}
    Input Text    ${Location_Textbox_Id}    ${LOCATION}
    
    
#### CLICK ON  THE SEARCH  BUTTON #### 
Clicking On Search Button
    [Documentation]    Click on the Search Button 
    Click Button    ${Search_Button_Id}  
    
    
#### RETRIVING THE COUNT OF PROPERTIES DISPLAYED ON THE PAGE ####     
Retrive Property Count
    [Documentation]    Getting the No.Of Proprties Displayed on the Page
    ${Property_Count}   Get Element Count    ${Retrive_Data_Xpath}
    set suite variable  ${Property_Count}
    Log To Console    *****   
    Log To Console    No.Of Properties are Displayed on the Page is : ${Property_Count}   
    
#### STORING THE PROPERTY VALUES IN LIST    
Storing Properties in List
    [Documentation]    Storing the Property Values in List
    ${Prop_Count}    Get Variable Value    ${Property_Count}    
    @{MyList}=    Create List
    :FOR    ${i}    IN RANGE    1   ${Prop_Count}+1     
    \    ${List1}=    Get Text    xpath:(//li[@id]//a[@class="listing-results-price text-price"])[${i}]
    \    Append To List     ${MyList}   ${List1}
    Set Suite Variable    ${MyList}    
    Log To Console    Properties Price List As Per Displayed Order:
    Log To Console    ${MyList}
    
    
#### ARRANGE THE LIST VALUES IN DESCENDING ORDER    
Arranging List in Descending Order
    [Documentation]    Property Values arrangement as per Descending Order
    @{MyLis}    Get Variable Value    ${MyList}    
    @{MyList1}=    Create List
    :FOR    ${i}    IN     @{MyLis}   
    \    ${Res}=    Input Segartion   ${i}
    \    Append To List    ${Mylist1}    ${Res}
    Sort List    ${MyList1}
    #Log To Console    Sorting values in Asscending Order : @{MyList1}
    Reverse List    ${MyList1}
    Log To Console    Properties Price List in Descending Order :
    Log To Console     ${MyList1}
    
#### SELECTING THE PROPERTY FROM THE LIST    
Selecting The Property From List Of Properties
    [Documentation]    Selecting the Property from the list
    Click Element    ${Selece_Property_Xpath} 
    
    
#### RETRIVING THE PROPERTY NAME    
Retriving The Property Name
    [Documentation]    Getting the Property Name
    ${Property}    Get Text    ${Prop_Name_Xpath}
    Set Suite Variable    ${Property}    
    Log To Console    Selected Property Name is :${Property}    

#### RETRIVING THE SELLER NAME AND SELECTION     
Retriving The Seller Name And Select On Seller
    [Documentation]    Getting the Seller Name and Selecting the Seller 
    ${Seller_Name}    Get Text    ${Owner_Name_Xpath}
    Log To Console    Property Seller Name is :${Seller_Name}
    Click Element    ${Owner_Name_Xpath}
    
    
#### COMPARING THE SELLER WITH PROPERTY
Checking The Listed Property Belongs To The Seller
    [Documentation]    Comparing the Property Listed in the Seller Proprety 
    ${Property Name At Seller Page}    Get Text    ${Property_Link_Xpath}
    ${Property Name At Listing Page}    Get Variable Value    ${Property}
    Should Be Equal    ${Property Name At Seller Page}    ${Property Name At Listing Page}