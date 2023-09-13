*** Settings ***
Library        SeleniumLibrary
Library        ExcelLibrary
Library        Collections
Library        ScreenCapLibrary

*** Test Cases ***
TC03
    
    # Start Video Recording    name=C:/Users/Admin/Desktop/Testdata/TC03_EditProfile  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    C:/Users/Admin/Desktop/Testdata/TC03_EditProfile.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status}    Set Variable If    "${excel.cell(${i},2).value}" == "None"    ${EMPTY}    ${excel.cell(${i},2).value}
        IF    "${status}" == "Y"
            ${tdid}        Set Variable If    "${excel.cell(${i},1).value}" == "None"    ${EMPTY}    ${excel.cell(${i},1).value}    
            Log To Console   ${tdid}
            ${pass}        Set Variable If    "${excel.cell(${i},3).value}" == "None"    ${EMPTY}    ${excel.cell(${i},3).value}
            ${frist}        Set Variable If    "${excel.cell(${i},4).value}" == "None"    ${EMPTY}    ${excel.cell(${i},4).value}
            ${last}        Set Variable If    "${excel.cell(${i},5).value}" == "None"    ${EMPTY}    ${excel.cell(${i},5).value}
            ${email}    Set Variable If    "${excel.cell(${i},6).value}" == "None"    ${EMPTY}    ${excel.cell(${i},6).value}
            ${address}    Set Variable If    "${excel.cell(${i},7).value}" == "None"    ${EMPTY}    ${excel.cell(${i},7).value}
            ${Tel}        Set Variable If    "${excel.cell(${i},8).value}" == "None"    ${EMPTY}    ${excel.cell(${i},8).value}
            ${EXP}         Set Variable       ${excel.cell(${i},9).value}
            
            Begin Webpage
            Click Element    //a[contains(text(),'Login')]
            Input Text    //input[@id='username']    User001
            Input Text    //input[@id='password']    123456
            Sleep    5s
            Click Button    //button[contains(text(),'Login')]
            Click Element    //a[contains(text(),'แก้ไขข้อมูลส่วนตัว')]
            Input Text    //input[@id='password']    ${pass}        
            Input Text    //input[@id='firstname']    ${frist}
            Input Text    //input[@id='lastname']    ${last}    
            Input Text    //input[@id='email']    ${email}
            Input Text    //textarea[@id='address']    ${address}    
            Input Text    //input[@id='mobilephone']    ${Tel}
            Sleep    5s
            Click Button    //button[contains(text(),'แก้ไขข้อมูล')]

            ${ACTUAL_RESULT}    Get Text    //a[contains(text(),'หน้าแรก')]  #เช็คerorr

             IF    "${ACTUAL_RESULT}" == "${EXP}"
                Write Excel Cell    ${i}    10    value= ${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    11   value=PASS    sheet_name=TestData
                Write Excel Cell    ${i}    12    value=No Error    sheet_name=TestData
                Write Excel Cell    ${i}    13    value= -    sheet_name=TestData

            ELSE
                Take Screenshot    name=C:/Users/Admin/Desktop/PicErorr/TC03_EditProfile${tdid}_Fail.png
                Write Excel Cell    ${i}    10    value=${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    11    value=FAIL    sheet_name=TestData
                Write Excel Cell    ${i}    12    value=Error   sheet_name=TestData
                Write Excel Cell    ${i}    13    value=ควรแจ้งเตือนผู้ใช้ว่า"${EXP}"    sheet_name=TestData
            END

            Sleep    5s
        END
    END
    Close All Browsers
    Save Excel Document    C:/Users/Admin/Desktop/ResultsData/TD03_Editprofile_Result.xlsx
    # Stop Video Recording

*** Keywords ***
Begin Webpage
    Open Browser            http://localhost:8081/CoffeeProject/openHome      chrome    executable_path=D:/chromedriver.exe
    Maximize Browser Window