*** Settings ***
Library        SeleniumLibrary
Library        ExcelLibrary
Library        Collections
Library        ScreenCapLibrary


*** Test Cases ***
TC04
    
    # Start Video Recording    name=C:/Users/Admin/Desktop/Testdata/TC04_AddEmployee  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    C:/Users/Admin/Desktop/Testdata/TC04_AddEmployee.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status}    Set Variable If    "${excel.cell(${i},2).value}" == "None"    ${EMPTY}    ${excel.cell(${i},2).value}
        IF    "${status}" == "Y"
            ${tdid}        Set Variable If    "${excel.cell(${i},1).value}" == "None"    ${EMPTY}    ${excel.cell(${i},1).value}    
            Log To Console   ${tdid}
            ${status}        Set Variable If   "${excel.cell(${i},3).value}" == "None"    ${EMPTY}    ${excel.cell(${i},3).value}
            ${EmpId}        Set Variable If    "${excel.cell(${i},4).value}" == "None"    ${EMPTY}    ${excel.cell(${i},4).value}
            ${EmpUes}       Set Variable If    "${excel.cell(${i},5).value}" == "None"    ${EMPTY}    ${excel.cell(${i},5).value}
            ${EmpPass}      Set Variable If    "${excel.cell(${i},6).value}" == "None"    ${EMPTY}    ${excel.cell(${i},6).value}
            ${EmpName}      Set Variable If    "${excel.cell(${i},7).value}" == "None"    ${EMPTY}    ${excel.cell(${i},7).value}
            ${EmpLast}      Set Variable If    "${excel.cell(${i},8).value}" == "None"    ${EMPTY}    ${excel.cell(${i},8).value}
            ${EmpMail}      Set Variable If    "${excel.cell(${i},9).value}" == "None"    ${EMPTY}    ${excel.cell(${i},9).value}   
            ${EmpAddress}   Set Variable If    "${excel.cell(${i},10).value}" == "None"    ${EMPTY}    ${excel.cell(${i},10).value}
            ${EmpPhone}     Set Variable If    "${excel.cell(${i},11).value}" == "None"    ${EMPTY}    ${excel.cell(${i},11).value} 
            ${EXP}          Set Variable       ${excel.cell(${i},12).value}
            
            Begin Webpage
            Click Element    //a[contains(text(),'Login')]
            Input Text    //input[@id='username']    Admin001
            Input Text    //input[@id='password']    123456
            Sleep    3s
            Click Button    //button[contains(text(),'Login')]

            Click Element    //a[contains(text(),'เพิ่มพนักงาน')]
            Input Text    //input[@id='memberid']    ${EmpId}
            Input Text    //input[@id='username']    ${EmpUes} 
            Input Text    //input[@id='password']    ${EmpPass}
            Input Text    //input[@id='firstname']    ${EmpName}
            Input Text    //input[@id='lastname']    ${EmpLast}
            Input Text    //input[@id='email']    ${EmpMail}
            Input Text    //input[@id='address']    ${EmpAddress}
            Input Text    //input[@id='mobilephone']    ${EmpPhone}       
            Sleep    3s  
            Click Button    //button[contains(text(),'เพิ่มพนักงาน')]     


           
            IF  "${status}" == "Emp"
            
            ${ACTUAL_RESULT}    Get Text    //h3[contains(text(),'กรุณาเข้าสู่ระบบ')]

            ELSE IF  "${status}" == "Tel"

                ${ACTUAL_RESULT}     Handle Alert 
            END

            
            
            IF    "${ACTUAL_RESULT}" == "${EXP}"
                Write Excel Cell    ${i}    13    value= ${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    14   value=PASS    sheet_name=TestData
                Write Excel Cell    ${i}    16    value=No Error    sheet_name=TestData
                Write Excel Cell    ${i}    17    value= -    sheet_name=TestData

            ELSE
                Take Screenshot    name=C:/Users/Admin/Desktop/PicErorr/TC04_AddEmployee${tdid}_Fail.png
                Write Excel Cell    ${i}    13    value=${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    14    value=FAIL    sheet_name=TestData
                Write Excel Cell    ${i}    16    value=Error   sheet_name=TestData
                Write Excel Cell    ${i}    17    value=ควรแจ้งเตือนผู้ใช้ว่า"${EXP}"    sheet_name=TestData
            END
            
            Close All Browsers
            Sleep    3s
        END
    END
    Save Excel Document    C:/Users/Admin/Desktop/ResultsData/TD04_AddEmployee_Result.xlsx
    # Stop Video Recording

*** Keywords ***
Begin Webpage
    Open Browser            http://localhost:8081/CoffeeProject/openHome      chrome    executable_path=D:/chromedriver.exe
    Maximize Browser Window
    Run keyword and ignore error    Handle Alert    timeout=5s   action=ACCEPT