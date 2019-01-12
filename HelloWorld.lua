-- Exibe o texto na tela
print('Hello World!')
print(12346)

--[[ Comentario
com mutiplas
linhas
]]--
print(1 + 1)
a = 1 + 1
print(a)
print("Utilizando modulo" .. " " .. 9 % 2)

-- Variaveis

x = "Ola Mundo!"
print(x)

-- Concatenar

print("Texto" .. ": " .. x)

-- tostring

estaAtivo = true
print("Valor de estaAtivo" .. ": " .. tostring(estaAtivo))
print("Wakatime")

-- nulo

y = nil
print(y)

-- Escape de texto: utiliza caractere de escape \
-- \n -> quebra de linhas
-- \t -> tabulação
-- \r -> retorno da tabulação

print("Caixa D\'agua")

-- Input e Output
-- io -> bilbioteca para entradas e saidas de dados

print("Qual seu nome?")
nome = io.read()
print("Entao seu nome é " .. nome .. "?")

-- Parei na aula 6/27
-- data: 10/01/19

-- Funções

function somarUm()
    print("Dentro da função")
    print(1 + 1)
--    return nil
end

-- _G -> chama variavel global

-- Condicionais

-- if, then, else, else if, end
-- ~= -> diferente
-- == -> igualdade
valor = 1
if valor == 1 then
    print("Dentro do if")
else 
    print("Dentro do else")
end

-- Laços

while valor == 1 do
    print("Dentro do while")
    valor = valor + 1
end

for i = 2, 10, 2 do
    print(i)
end

indice = 1
repeat
    print(INDICE)
until indice >= 10

--Arrays

matriz = {
    10, 20, 30
}
print(matriz[2])
-- # -> qtd de posições no Array
print(#matriz)

-- Dicionario

items = {
    valor1 = 100
    ["test"] = 200
}

print(items.valor1)
print(items["test"])

-- Importe
-- Exporte: return nomeFuncao

local var = required("nomeArquivo")

-- Parei na aula 21/ 24
-- Data 12/01/19