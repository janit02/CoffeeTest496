*** Settings ***
Library        SeleniumLibrary
Library        ExcelLibrary
Library        Collections
Library        ScreenCapLibrary
Library        SelectDay.py

# *** Variables ***
# ${CLICK_DATE}         xpath=(//android.widget.ImageView)[3]
# ${HEADER_YEAR}        id=android:id/date_picker_header_year
# ${HEADER_DATE}        id=android:id/date_picker_header_date
# ${OK_YEAR_BTN}        id=android:id/button1
# ${YEAR_LIST}          xpath=//android.widget.ListView/android.widget.TextView
# ${MONTH_AND_YEAR}     xpath=(//android.view.View/android.view.View)[1]
# ${PREV_BTN}           id=android:id/prev
# ${NEXT_BTN}           id=android:id/next
# ${DAY_LIST}           xpath=//android.view.View/android.view.View

*** Test Cases ***
TC06
    #อัดวีดีโอ ค่อยเปิดตอนจะอัดจริงๆ
    # Start Video Recording    name=D:/TestCoffee496/Testdata/TC06_Payment  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    D:/TestCoffee496/Testdata/TC06_Payment.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status}    Set Variable If    "${excel.cell(${i},2).value}" == "None"    ${EMPTY}    ${excel.cell(${i},2).value}
        IF    "${status}" == "Y"
            ${tdid}        Set Variable If    "${excel.cell(${i},1).value}" == "None"    ${EMPTY}    ${excel.cell(${i},1).value}    
            Log To Console   ${tdid}
            ${accout}        Set Variable If    "${excel.cell(${i},3).value}" == "None"    ${EMPTY}    ${excel.cell(${i},3).value}
            ${mobank}        Set Variable If    "${excel.cell(${i},4).value}" == "None"    ${EMPTY}    ${excel.cell(${i},4).value}
            ${money}         Set Variable If    "${excel.cell(${i},5).value}" == "None"    ${EMPTY}    ${excel.cell(${i},5).value}
            ${date}          Set Variable If    "${excel.cell(${i},6).value}" == "None"    ${EMPTY}    ${excel.cell(${i},6).value}
            ${time}          Set Variable If    "${excel.cell(${i},7).value}" == "None"    ${EMPTY}    ${excel.cell(${i},7).value}
            ${recipe}        Set Variable If    "${excel.cell(${i},8).value}" == "None"    ${EMPTY}    ${excel.cell(${i},8).value}
            ${EXP}           Set Variable       ${excel.cell(${i},9).value}
            
            Begin Webpage
            Click Element    //a[contains(text(),'Login')]
            Input Text    //input[@id='username']    User001
            Input Text    //input[@id='password']    123456
            Sleep    3s
            Click Button    //button[contains(text(),'Login')]

            Click Element    //a[contains(text(),'แจ้งการชำระเงิน')]
            Click Element    (//div[@class='input-group-prepend']//select)[${accout}]
            Click Element    (//div[@class='input-group-prepend']//select)[${mobank}] 
            Input Text    //input[@id='transferamount']    ${money}
            Input Text    //input[@id='stockDate']    ${date} 
            Input Text    //input[@id='timetransfer']    ${time} 
            Choose File    (//input[@type="file"])     ${recipe}
            Sleep    5s
            Click Button    //button[contains(text(),'ยืนยันการแจ้งโอนเงิน')]
            
            ${ACTUAL_RESULT}    Get Text    //body//h1       #เช็คerorr   #ยังไม่เสร็จ


            IF    "${ACTUAL_RESULT}" == "${EXP}"
                Write Excel Cell    ${i}    10    value= ${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    11    value=PASS    sheet_name=TestData
                Write Excel Cell    ${i}    13    value=No Error    sheet_name=TestData
                Write Excel Cell    ${i}    14    value= -    sheet_name=TestData

            ELSE
                Take Screenshot    name=D:/TestCoffee496/PicErorr/TC02_Register${tdid}_Fail.png
                Write Excel Cell    ${i}    10    value=${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    11    value=FAIL    sheet_name=TestData
                Write Excel Cell    ${i}    13    value=Error   sheet_name=TestData
                Write Excel Cell    ${i}    14    value=ควรแจ้งเตือนผู้ใช้ว่า"${EXP}"    sheet_name=TestData
            END

            Sleep    5s
        END
    END
    Close All Browsers
    Save Excel Document    D:/TestCoffee496/ResultsData/TD06_Payment_Result1.xlsx
    # Stop Video Recording

*** Keywords ***
Begin Webpage
    Open Browser            http://localhost:8081/CoffeeProject/openHome      chrome    executable_path=D:/chromedriver.exe
    Maximize Browser Window

# Select day
#     [Arguments]    ${date_come_in}
#     Wait Until Element Is Visible    ${HEADER_YEAR}    10s
#     ${CURR_YEAR}    Get Text    ${HEADER_YEAR}
#     ${CURR_DATE}    Get Text    ${HEADER_DATE}
#     Click Element    ${HEADER_YEAR}
#     ${DATE_TARGET_ARRAY}=    Split Str By Slash    ${date_come_in}
#     ${TARGET_DAY}=    Set Variable    ${DATE_TARGET_ARRAY}[0]
#     ${TARGET_MONTH}=    Set Variable    ${DATE_TARGET_ARRAY}[1]
#     ${TARGET_YEAR}=    Set Variable    ${DATE_TARGET_ARRAY}[2]

#     FOR    ${j}  IN RANGE    100
#                 ${elements}    Get Webelements    ${YEAR_LIST}
#                 ${flag}    Set Variable    20
#                 ${str}    Set Variable    20
#                 FOR    ${elem}    IN    @{elements}
#                     ${str}=    Get Text    ${elem}
#                     IF    ${str} == ${TARGET_YEAR}
#                         Click Element    ${elem}
#                         ${flag}    Set Variable    ${str}
#                         Exit For Loop
#                     END
#                 END
#                 Exit For Loop If    ${str} == ${flag}
#                 # ${FIRST_ELEM}=    Set Variable    ${elements}[0]
#                 # ${TEXT_OF_FIRST}=    Get Text    ${FIRST_ELEM} 
#                 # IF    ${TEXT_OF_FIRST} < ${TARGET_YEAR}
#                 #     Swipe By Percent    50    65    50    35    1000
#                 # ELSE IF    ${TEXT_OF_FIRST} > ${TARGET_YEAR}
#                 #     Swipe By Percent    50    35    50    65    1000
#                 # END
#             END

#             FOR  ${i}  IN RANGE    100
#                 ${content_desc}=    Get Element Attribute    ${MONTH_AND_YEAR}    content-desc
#                 ${res_content_desc}=    Split Month And Date    ${content_desc}
#                 ${date}=    Set Variable    ${res_content_desc}[0]
#                 ${month}=    Set Variable    ${res_content_desc}[1]
#                 ${num_month}=    Convert Month To Number    ${month}
#                 ${INT_TARGET_MONTH}=    Str To Int    ${TARGET_MONTH}
#                 IF    ${num_month} > ${INT_TARGET_MONTH}
#                     Click Element    ${PREV_BTN}
#                 ELSE IF    ${num_month} < ${INT_TARGET_MONTH}
#                     Click Element    ${NEXT_BTN}
#                 ELSE
#                     ${days}    Get Webelements    ${DAY_LIST}
#                     FOR    ${day}    IN    @{days}
#                         ${day_content_desc}=    Get Element Attribute    ${day}    content-desc
#                         ${day_content_desc_arr}=    Split Str By Space    ${day_content_desc}
#                         ${real_day}=    Set Variable    ${day_content_desc_arr}[0]
#                         ${num_day}=    Str To Int    ${real_day}
#                         ${TARGET_DAY_INT}=    Str To Int    ${TARGET_DAY}
#                         IF    ${num_day} == ${TARGET_DAY_INT}
#                             Click Element    ${day}
#                             Exit For Loop
#                         END
#                     END
#                     Exit For Loop
#                 END
#             END

#             Wait Until Element Is Visible    ${OK_YEAR_BTN}    10s
#             Click Element    ${OK_YEAR_BTN}
           