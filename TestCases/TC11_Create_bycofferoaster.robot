*** Settings ***
Library        SeleniumLibrary
Library        ExcelLibrary
Library        Collections
Library        ScreenCapLibrary

*** Test Cases ***  
TC11
    
    # Start Video Recording    name=C:/Users/Admin/Desktop/TC11_CreateOrderbyCoffeeRoaster  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    C:/Users/Admin/Desktop/Testdata/TC11_CreateOrderbyCoffeeRoaster.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status}    Set Variable If    "${excel.cell(${i},2).value}" == "None"    ${EMPTY}    ${excel.cell(${i},2).value}
        IF    "${status}" == "Y"
            ${tdid}        Set Variable If    "${excel.cell(${i},1).value}" == "None"    ${EMPTY}    ${excel.cell(${i},1).value}    
            Log To Console   ${tdid}
            # ${selectcoffee}    Set Variable If    "${excel.cell(${i},3).value}" == "None"    ${EMPTY}    ${excel.cell(${i},3).value}
            ${mashed}    Set Variable If    "${excel.cell(${i},3).value}" == "None"    ${EMPTY}    ${excel.cell(${i},3).value}
            ${weight}    Set Variable If    "${excel.cell(${i},5).value}" == "None"    ${EMPTY}    ${excel.cell(${i},5).value} 
            ${EXP}    Set Variable       ${excel.cell(${i},6).value}
            
            Begin Webpage
            Click Element    //a[contains(text(),'Login')]
            Input Text    //input[@id='username']    User001
            Input Text    //input[@id='password']    123456
            Sleep    5s
            Click Button    //button[contains(text(),'Login')]

            Click Element    //a[@id='navbardrop']
            Click Element    //a[contains(text(),'กาแฟของทางโรงคั่ว')]
            
            Click Element    //select[@id='coffeeid']
            Sleep    5s
            # บดเมล็ดกาแฟ
            Click Element   (//option[@value='${mashed}'])    
            # Checkbox Should Be Selected    //input[@id='serviceid']   
            Sleep    5s
            
        # Wait Until Page Contains Element  ${sn_color}   10s
        #      Click Element    ${sn_color}
        #     IF    '${color}' == 'ดำ' 
        #         Wait Until Page Contains Element    ${sn_clr}    10s
        #             Click Element    ${sn_clr}
        #         Sleep    1s
        #     ELSE IF  '${color}' == 'แดง' 
        #         Wait Until Page Contains Element    ${sn_clb}   10s
        #             Click Element    ${sn_clb}
        #         Sleep    1s
        #     END
                   
            # ${selectcoffee}=     Select Checkbox    (//option[@value="[${i}]"])
  
            # Click Element    ${selectcoffee}  

            # # Click Element    //select[@id='coffeeid']    ${selectcoffee}  ติดตรงเลือกSelectCoffee
            # # Sleep    5s

            # # [บดเมล็ดหรือไม่บด]
            # Click Button    //input[@id='serviceid']
            # Click Element    //input[@id='option2']
            
            # # [เลือกบริการแพ็คถุงหรือไม่แพ็คถุง]ยังไม่ถูก
            # Click Element   //input[@id='option4']
            # # Click Element   //input[@id='option5']
            # # Click Element   //input[@id='option6']
            # # Click Element   //input[@id='option7']
            # # Click Element   //input[@id='option8']
            
            # # input weight coffee
            # Input Text    //input[@id='coffeeweight']    ${weight}
            
            
            # คำนวนค่าใช้จ่ายถูกไหม?
            # Get Text    //input[@id='payment']    

            # เหลือดึงค่าลิงค์หน้ามาเช็ค!!!!

            # กรอกถูกแล้วแต่ไม่ Pass ให้ !!!!!
            ${ACTUAL_RESULT}    Get Value    //input[@id='payment']  #เช็คerorr

            IF    "${ACTUAL_RESULT}" == "${EXP}"
                Write Excel Cell    ${i}    7    value= ${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    8   value=PASS    sheet_name=TestData
                Write Excel Cell    ${i}    9    value=No Error    sheet_name=TestData
                Write Excel Cell    ${i}    10    value= -    sheet_name=TestData

            ELSE
                Take Screenshot    name=C:/Users/Admin/Desktop/PicErorr/TC11_Login${tdid}_Fail.png
                Write Excel Cell    ${i}    7    value=${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    8    value=FAIL    sheet_name=TestData
                Write Excel Cell    ${i}    9    value=Error   sheet_name=TestData
                Write Excel Cell    ${i}    10    value=ควรแจ้งเตือนผู้ใช้ว่า"${EXP}"    sheet_name=TestData
            END
            Sleep    5s
            Close All Browsers
            Sleep    5s
            # Click Button    //button[contains(text(),'สั่ง')]
        END
    END
    
    Save Excel Document    C:/Users/Admin/Desktop/ResultsData/TD11_CreateOrderbyCoffeeRoaster.xlsx
    # Stop Video Recording

*** Keywords ***
Begin Webpage
    Open Browser            http://localhost:8081/CoffeeProject/openHome      chrome    executable_path=D:/chromedriver.exe
    Maximize Browser Window
    