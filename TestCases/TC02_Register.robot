*** Settings ***
Library        SeleniumLibrary
Library        ExcelLibrary
Library        Collections
Library        ScreenCapLibrary


*** Test Cases ***
TC02
    
    # Start Video Recording    name=C:/Users/Admin/Desktop/Testdata/TC02_Register  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    C:/Users/Admin/Desktop/Testdata/TC02_Register.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status}    Set Variable If    "${excel.cell(${i},2).value}" == "None"    ${EMPTY}    ${excel.cell(${i},2).value}
        IF    "${status}" == "Y"
            ${tdid}        Set Variable If    "${excel.cell(${i},1).value}" == "None"    ${EMPTY}    ${excel.cell(${i},1).value}    
            Log To Console   ${tdid}

            ${RE_IDmember}    Set Variable If    "${excel.cell(${i},3).value}" == "None"    ${EMPTY}    ${excel.cell(${i},3).value}
            ${RE_Username}    Set Variable If    "${excel.cell(${i},4).value}" == "None"    ${EMPTY}    ${excel.cell(${i},4).value}
            ${RE_Password}    Set Variable If    "${excel.cell(${i},5).value}" == "None"    ${EMPTY}    ${excel.cell(${i},5).value}
            ${RE_Firstname}   Set Variable If    "${excel.cell(${i},6).value}" == "None"    ${EMPTY}    ${excel.cell(${i},6).value}
            ${RE_Lastname}    Set Variable If    "${excel.cell(${i},7).value}" == "None"    ${EMPTY}    ${excel.cell(${i},7).value}
            ${RE_Gmail}       Set Variable If    "${excel.cell(${i},8).value}" == "None"    ${EMPTY}    ${excel.cell(${i},8).value}
            ${RE_Address}     Set Variable If    "${excel.cell(${i},9).value}" == "None"    ${EMPTY}    ${excel.cell(${i},9).value}
            ${LOG_Tel}        Set Variable If    "${excel.cell(${i},10).value}" == "None"    ${EMPTY}    ${excel.cell(${i},10).value}     
            ${EXP}         Set Variable       ${excel.cell(${i},11).value}
            Begin Webpage
            Click Element    //a[contains(text(),'Register')]
            Input Text    //input[@id='memberid']    ${RE_IDmember}
            Input Text    //input[@id='username']    ${RE_Username}
            Input Text    //input[@id='password']    ${RE_Password}
            Input Text    //input[@id='firstname']    ${RE_Firstname}
            Input Text    //input[@id='lastname']    ${RE_Lastname}
            Input Text    //input[@id='email']    ${RE_Gmail} 
            Input Text    //textarea[@id='address']    ${RE_Address}
            Input Text    //input[@id='mobilephone']    ${LOG_Tel}
            Sleep    5s
            Click Button    //button[contains(text(),'สมัครสมาชิก')]     
            
            
            ${ACTUAL_RESULT}    Handle Alert       #เช็คerorr   #ยังไม่เสร็จ


            IF    "${ACTUAL_RESULT}" == "${EXP}"
                Write Excel Cell    ${i}    12    value= ${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    13   value=PASS    sheet_name=TestData
                Write Excel Cell    ${i}    15    value=No Error    sheet_name=TestData
                Write Excel Cell    ${i}    16    value= -    sheet_name=TestData

            ELSE
                Take Screenshot    name=C:/Users/Admin/Desktop/PicErorr/TC02_Register${tdid}_Fail.png
                Write Excel Cell    ${i}    12    value=${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    13    value=FAIL    sheet_name=TestData
                Write Excel Cell    ${i}    15    value=Error   sheet_name=TestData
                Write Excel Cell    ${i}    16    value=ควรแจ้งเตือนผู้ใช้ว่า"${EXP}"    sheet_name=TestData
            END
            
            Close All Browsers
            Sleep    5s
        END
    END
    Save Excel Document    C:/Users/Admin/Desktop/ResultsData/TD02_Register_Result.xlsx
    # Stop Video Recording

*** Keywords ***
Begin Webpage
    Open Browser            http://localhost:8081/CoffeeProject/openHome      chrome    executable_path=D:/chromedriver.exe
    Maximize Browser Window