*** Settings ***
Library    SeleniumLibrary 
Library    ../Utils/utils.py     
Library    Collections 
Resource    ../Pages/HomePage.robot
Suite Setup    Browser Launch
Suite Teardown    Browser Close


*** Test Cases ***
TEST CASE 1 LOGIN
    
    Entering Search Location
    Clicking On Search Button
    Retrive Property Count
    Storing Properties in List
    Arranging List in Descending Order
    Selecting The Property From List Of Properties
    Retriving The Property Name
    Retriving The Seller Name And Select On Seller
    Checking The Listed Property Belongs To The Seller