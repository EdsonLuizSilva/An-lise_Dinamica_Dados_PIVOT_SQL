# Análise de Dados com SQL Server: Explorando a Flexibilidade do PIVOT
## Introdução
A análise de dados é uma prática essencial nos dias de hoje, permitindo que empresas e organizações tomem decisões informadas e estratégicas para o seu crescimento. No campo da análise de dados, o SQL (Structured Query Language) é uma ferramenta poderosa que permite consultar e manipular dados em bancos de dados relacionais. Entre os desafios enfrentados na análise de dados, está a necessidade de resumir e agregar informações de forma organizada e compreensível. Neste contexto, a cláusula PIVOT do SQL Server desempenha um papel importante, possibilitando a transformação de dados em formato de tabela.

Neste Estudo, exploraremos o conceito de PIVOT no SQL Server e apresentaremos um código que demonstra como realizar uma análise dinâmica de dados usando essa cláusula. Além disso, veremos como a abordagem dinâmica permite que a consulta se adapte automaticamente a mudanças nos dados, tornando-a mais flexível e eficiente.
## Objetivo
O objetivo deste estudo é fornecer uma compreensão clara do uso da cláusula PIVOT no SQL Serve para realizar uma análise dinâmica de dados. Apresentaremos um código passo a passo, que permitirá contar registros com base em valores únicos encontrados em uma coluna específica da tabela. Ao final deste estudo, os leitores terão uma visão abrangente de como aplicar a cláusula PIVOT de forma eficiente em suas análises, permitindo uma consulta mais flexível e adaptável.
## Explorando o Código Passo a Passo:
O código abaixo mostra como usar o PIVOT para realizar uma análise dinâmica de dados.

```
USE AdventureWorks2019
GO

DECLARE @CountryNames NVARCHAR(4000) = '';
DECLARE @SQLDinamico NVARCHAR(4000) = '';

SELECT @CountryNames += quotename(CountryRegionName)+','
FROM AdventureWorks2019.Sales.vIndividualCustomer
GROUP BY CountryRegionName

SET @CountryNames = substring(@CountryNames, 1, len(@CountryNames)-1)

SET @SQLDinamico = 'SELECT *
    FROM
        (SELECT
             CountryRegionName,
             StateProvinceName,
             BusinessEntityID
         FROM AdventureWorks2019.Sales.vIndividualCustomer)as tabular
    PIVOT (
            count (BusinessEntityID)
            FOR CountryRegionName
            IN('+ @CountryNames +')
            ) as NewPivot'

EXEC (@SQLDinamico)
```
1
```
DECLARE @CountryNames NVARCHAR(4000) = '';
DECLARE @SQLDinamico NVARCHAR(4000) = '';
```
-Nesta etapa inicial do código, declaramos a variável ```@CountyNames``` e a inicializamos com uma string vazia. Essa variável será usada para armazenar a lista dos nomes dos países presentes na coluna ```CountryRegionName``` da tabela ```AdventureWorks2019.Sales.vIndividualCustomer```. 

-Declaramos a variável ```@SQLDinamico```, que será usada para armazenar a consulta SQL dinâmica que será construída para executar a cláusula PIVOT com base nos valores únicos de países.

2
```
SELECT @CountryNames += quotename(CountryRegionName)+','
FROM AdventureWorks2019.Sales.vIndividualCustomer
GROUP BY CountryRegionName
```
-Aqui, estamos construindo a lista de nomes de países. Utilizamos a função ```quotename()``` para garantir que os nomes sejam formatados corretamente, especialmente se eles contiverem caracteres especiais. A cláusula ```GROUP BY``` garante que apenas valores únicos sejam considerados, evitando repetições na lista.

3
```
SET @CountryNames = substring(@CountryNames, 1, len(@CountryNames)-1)
```
-Nesta etapa, removemos a vígula extra no final da lista de nomes de países, pois o último nome da lista também teria uma vírgula ao final.

4
```
SET @SQLDinamico = 'SELECT *
    FROM
        (SELECT
             CountryRegionName,
             StateProvinceName,
             BusinessEntityID
         FROM AdventureWorks2019.Sales.vIndividualCustomer)as tabular
    PIVOT (
            count (BusinessEntityID)
            FOR CountryRegionName
            IN('+ @CountryNames +')
            ) as NewPivot'
```
-Nesta etapa, construímos a consulta SQL dinâmica. O trecho ```'+@CountryNames+'``` é onde inserimos a lista de nomes de países que foi construída anteriomente. Essa abordagem dinâmica permitirá que a consulta PIVOT seja criada com base nos valores únicos de países presente na varável ```@CountryNames```.

5
```
EXEC (@SQLDinamico)
```
-Finalmente, executamos a consulta SQL dinâmica construída anteriormente usando a função ```EXEC()```. Isso realizará a contagem dos registros (BusinessEntityID) agrupados por CountryRegionName, criando uma tabela pivô com as informações desejadas conforme a figura abaixo.

![tabela pivot](https://github.com/EdsonLuizSilva/Analise_Dinamica_Dados_PIVOT_SQL_SERVER/assets/65295796/1e737d85-2173-4afb-afb9-9c6536100891)
## Conclusão
A análise dinâmica de dados usando a cláusula PIVOT no SQL Serve é uma ferramenta valiosa para resumir e agregar informações importantes em formato tabular. O código corrigido apresentado neste estudo demonstrou como contar registros com base em valores únicos de uma coluna específica da tabela, permitindo uma análise mais flexível e adaptável.

A abordagem dinâmica na construção da consulta SQL proporciona uma análise mais abrangente, capaz de lidar com mudanças nos dados de forma automática. Isso torna o código mais eficiente e menos suscetível a erros humanos. Ao aplicar o conceito de PIVOT no SQL Server, os profissionais de análise de dados podem otimizar suas consultas e análises, proporcionando informações mais precisas e úteis para a tomada de decisões informadas em diversos contextos e setores.

Em suma, a cláusula PIVOT no SQL Server é uma aliada poderosa para a análise dinâmica de dados, e a abordagem dinâmica torna a consulta mais flexível e adaptável, garantindo análises atualizadas e precisas para impulsionar o sucesso organizacional.
