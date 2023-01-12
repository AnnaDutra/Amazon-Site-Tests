*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${BROWSER}               chrome
${URL}                   http://www.amazon.com.br
${MENU_ELETRONICOS}      //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${HEADER_ELETRONICOS}    //h1[contains(.,'Eletrônicos e Tecnologia')]
             

*** Keywords ***
Abrir o navegador
    Open Browser       browser=${BROWSER}
    Maximize Browser Window 

Fechar o Navegador 
    Capture Page Screenshot    
    Close Browser  

Acessar a home page do site Amazon.com.br  
    Go To                            url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Eletrônicos"   
    Click Element                    locator=${MENU_ELETRONICOS} 

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains          text=${FRASE} 
    Wait Until Element Is Visible     locator=${MENU_ELETRONICOS}

Verificar se o título da página fica "${TITULO}"
   Title Should Be                     title=${TITULO}
  
Verificar se aparece a categoria "${CATEGORIA}"  
    Element Should Be Visible    locator=(//a[@aria-label='Computadores e Informática'])[2]

#teste2
Digitar o nome de produto "${PRODUTO}" no campo de pesquisa 
    Input Text    locator=twotabsearchtextbox    text=${PRODUTO}

Clicar no botão de pesquisa    
    Click Element    locator=nav-search-submit-button

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    locator=(//span[contains(.,'${PRODUTO}')])[2]

#GHERKIN STEPS

Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br
    
Quando acessar o menu "Eletrônicos"    
    Entrar no menu "Eletrônicos" 
Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"
E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"
E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"
Quando pesquisar pelo produto "Xbox Series S"    
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"
E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"

    #teste3
 Adicionar o produto "Console Xbox Series S" no carrinho
    Click Element                    locator=(//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'Console Xbox Series S')])[1]
    Click Button                     id=add-to-cart-button        
 Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso
    Wait Until Element Is Visible    locator=//span[@class='a-size-medium-plus a-color-base sw-atc-text a-text-bold'][contains(.,'Adicionado ao carrinho')]
    Verificar se aparece a frase "Adicionado ao carrinho"
    Click Element                    locator=//a[contains(.,'Ir para o carrinho')]
   #teste4
Remover o produto "Console Xbox Series S" do carrinho
    # Click Element                    locator=//a[contains(.,'Ir para o carrinho')]
    # Wait Until Element Is Visible    locator=//span[@class='a-truncate-cut'][contains(.,'Console Xbox Series S')]
    Click Button                     locator=//input[@value='Excluir']    
 Verificar se o carrinho fica vazio
     Wait Until Element Is Visible    locator=//h1[@class='a-spacing-mini a-spacing-top-base'][contains(.,'Seu carrinho de compras da Amazon está vazio.')]
