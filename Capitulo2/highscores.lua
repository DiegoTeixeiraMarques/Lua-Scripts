local composer = require( "composer" )
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

																						-- ### INICIALIZANDO VARIÁVEIS ### --

local json = require( "json" )															-- Importando as funcionalidades JSON em LUA
local scoresTable = {}																	-- Tabela que conterá os 10 maiores scores do jogo
local filePath = system.pathForFile( "scores.json", system.DocumentsDirectory )			-- Diretório onde será salvo o arquivo de maiores scores do jogo

																						-- ### CARREGANDO SCORES SALVOS ### --

local function loadScores()																-- Início da função

    local file = io.open( filePath, "r" )												-- Solicita a abertura do arquivo de scores em modo de leitura apenas
 
    if file then																		-- Verifica se o arquivo existe
		local contents = file:read( "*a" )												-- Despeja o conteúdo do arquivo na variável contents
		io.close( file )																-- Fecha o arquivo scores
        scoresTable = json.decode( contents )											-- Converte o JSON para uma tabela LUA
    end
	
    if ( scoresTable == nil or #scoresTable == 0 ) then									-- Se o arquivo não existir
        scoresTable = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }									-- Atribua dez valores 0 a variável para representar o que seria as dez maiores pontuações
    end
end																						-- Fim da função

																						-- ### SALVA SCORES DO JOGO ### --

local function saveScores()																-- Início da função
 
    for i = #scoresTable, 11, -1 do														-- Loop em todos os Scores salvos na tabela de pontuação
        table.remove( scoresTable, i )													-- Removendo pontuações desnecessárias
	end																					
 
    local file = io.open( filePath, "w" )												-- Abre o arquivo de scores em modo de escrita que permite subescrever o que já existe
 
    if file then																		-- Se o arquivo estiver aberto
        file:write( json.encode( scoresTable ) )										-- Escreva as pontuações que estão na tabela de scores para o arquivo	
        io.close( file )																-- Fecha o arquivo	
    end																					
end																						-- Fim da função

local function gotoMenu()																-- Início da função
    composer.gotoScene( "menu", { time=800, effect="crossFade" } )							-- Adiciona o link ao menu e efeito de transição entre telas
end																						-- FIm função

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	loadScores()																		-- Carrega as pontuações existentes
	table.insert( scoresTable, composer.getVariable( "finalScores" ) )					-- Insere a pontuação mais recente do jogador na tabela
	composer.setVariable( "finalScores", 0 )											-- Redefine o valor da finalScore para 0

	 -- Sort the table entries from highest to lowest
	local function compare( a, b )														-- Função para comparar dois valores															
		return a > b																	-- Retorna True ou False	
 	end
 	table.sort( scoresTable, compare )													-- Ordena a tabela de Scores e chama a função de comparação

	saveScores()																		-- Salva os Scores no arquivo JSON
	
	local background = display.newImageRect( sceneGroup, "background.png", 800, 1400 )	-- Cria o background para tela de highScores
    background.x = display.contentCenterX												-- Centraliza o background no eixo X
    background.y = display.contentCenterY												-- Centraliza o background no eixo Y
     
	local highScoresHeader = display.newText( sceneGroup, "High Scores", 
								display.contentCenterX, 100, native.systemFont, 44 )	-- Cria caixa de texto para apresentar os High Scores do jogo
	
	for i = 1, 10 do																	-- Loop para percorer a tabela de scores
        if ( scoresTable[i] ) then
            local yPos = 150 + ( i * 56 )												-- Ajusta a posição que aparecerá os dados
			local rankNum = display.newText( sceneGroup, i .. ")", 
								display.contentCenterX-50, yPos, native.systemFont, 36) -- Cria uma numeração sequencial de 1) até 10) para classificar na tela os scores
            rankNum:setFillColor( 0.8 )													-- Dar cor ao elemento
            rankNum.anchorX = 1															-- Alinhamento dos testos da tela
 
			local thisScore = display.newText( sceneGroup, scoresTable[i], 	
								display.contentCenterX-30, yPos, native.systemFont, 36 )
            thisScore.anchorX = 0
        end
	end

	local menuButton = display.newText( sceneGroup, "Menu", display.contentCenterX, 
											810, native.systemFont, 44 )				-- Instancia o botão Menu para voltar ao menu
    menuButton:setFillColor( 0.75, 0.78, 1 )											-- Dar cor ao botão
	menuButton:addEventListener( "tap", gotoMenu )										-- Adiciona o evento de tap ao botão que redireciona a tela de Menu do jogo
	
end



-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		composer.removeScene("highscores")												-- Remove a cena do jogo
	end
end

-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
