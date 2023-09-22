*** Settings ***
Library        SeleniumLibrary
Library        ExcelLibrary
Library        Collections
Library        ScreenCapLibrary

*** Test Cases ***  
TC11
    
    # Start Video Recording    name=D:/TestCoffee496/Testdata/TC11_CreateOrderbyCoffeeRoaster  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    D:/TestCoffee496/Testdata/TC11_CreateOrderbyCoffeeRoaster.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status}    Set Variable If    "${excel.cell(${i},2).value}" == "None"    ${EMPTY}    ${excel.cell(${i},2).value}
        IF    "${status}" == "Y"
            ${tdid}        Set Variable If    "${excel.cell(${i},1).value}" == "None"    ${EMPTY}    ${excel.cell(${i},1).value}    
            Log To Console   ${tdid}
            ${mashed}    Set Variable If    "${excel.cell(${i},3).value}" == "None"    ${EMPTY}    ${excel.cell(${i},3).value}
            # ${crush}     Set Variable If    "${excel.cell(${i},4).value}" == "None"    ${EMPTY}    ${excel.cell(${i},4).value}
            ${crushCoffee}  Set Variable If    "${excel.cell(${i},5).value}" == "None"    ${EMPTY}    ${excel.cell(${i},5).value}
            ${crushCoffee}  Set Variable If    "${excel.cell(${i},5).value}" == "None"    ${EMPTY}    ${excel.cell(${i},5).value}
            ${packsip}      Set Variable If    "${excel.cell(${i},6).value}" == "None"    ${EMPTY}    ${excel.cell(${i},6).value}
            ${weight}    Set Variable If    "${excel.cell(${i},7).value}" == "None"    ${EMPTY}    ${excel.cell(${i},7).value} 
            ${EXP}    Set Variable       ${excel.cell(${i},8).value}
            
            Begin Webpage
            Click Element    //a[contains(text(),'Login')]
            Input Text       //input[@id='username']    User001
            Input Text       //input[@id='password']    123456
            Sleep    5s
            Click Button     //button[contains(text(),'Login')]

            Click Element    //a[@id='navbardrop']
            Click Element    //a[contains(text(),'กาแฟของทางโรงคั่ว')]
            
            Click Element    //select[@id='coffeeid']
            Sleep    5s
            # บดเมล็ดกาแฟ
            Click Element   (//option[@value='${mashed}'])    
            # Click Element   //input[@id='serviceid'][${crush}]   
            Sleep    3s
            # บริการบดกาแฟ have radio option2,3
            Click Element    //input[@type='radio' and @id='${crushCoffee}']
            # บริการแพ็คถุง have radio option4,5,6,7,8
            Click Element    //input[@type='radio' and @id='${packsip}']
            Input Text    //input[@id='coffeeweight']    ${weight}
            Sleep    5s

            ${ACTUAL_RESULT}    Get Value    //input[@id='payment']  #เช็คerorr

            IF    "${ACTUAL_RESULT}" == "${EXP}"
                Write Excel Cell    ${i}    9    value= ${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    10   value=PASS    sheet_name=TestData
                Write Excel Cell    ${i}    12   value=No Error    sheet_name=TestData
                Write Excel Cell    ${i}    13   value= -   sheet_name=TestData

            ELSE
                Take Screenshot    name=C:/Users/Admin/Desktop/PicErorr/TC11_Login${tdid}_Fail.png
                Write Excel Cell    ${i}    9    value=${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    10   value=FAIL    sheet_name=TestData
                Write Excel Cell    ${i}    12   value=Error   sheet_name=TestData
                Write Excel Cell    ${i}    13   value=ค่าใช้จ่ายในการแปรรูปที่ถูกต้องคือ"${EXP}"บาท  sheet_name=TestData
            END
            Sleep    5s
            Close All Browsers
            Sleep    5s
            # Click Button    //button[contains(text(),'สั่ง')]
        END
    END
    
    Save Excel Document    D:/TestCoffee496/ResultsData/TD11_CreateOrderbyCoffeeRoaster_Result1.xlsx
    # Stop Video Recording

*** Keywords ***
Begin Webpage
    Open Browser            http://localhost:8081/CoffeeProject/openHome      chrome    executable_path=D:/chromedriver.exe
    Maximize Browser Window
    