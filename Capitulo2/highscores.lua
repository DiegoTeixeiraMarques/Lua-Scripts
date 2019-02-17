-- Parei na exibição de pontuações altas do capítulo 6

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

    local file = io.open( filePath, "r" )													-- Solicita a abertura do arquivo de scores em modo de leitura apenas
 
    if file then																				-- Verifica se o arquivo existe
		local contents = file:read( "*a" )														-- Despeja o conteúdo do arquivo na variável contents
		io.close( file )																		-- Fecha o arquivo scores
        scoresTable = json.decode( contents )													-- Converte o JSON para uma tabela LUA
    end
	
    if ( scoresTable == nil or #scoresTable == 0 ) then										-- Se o arquivo não existir
        scoresTable = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }										-- Atribua dez valores 0 a variável para representar o que seria as dez maiores pontuações
    end
end																						-- Fim da função

																						-- ### SALVA SCORES DO JOGO ### --

local function saveScores()																-- Início da função
 
    for i = #scoresTable, 11, -1 do															-- Loop em todos os Scores salvos na tabela de pontuação
        table.remove( scoresTable, i )															-- Removendo pontuações desnecessárias
	end																					
 
    local file = io.open( filePath, "w" )													-- Abre o arquivo de scores em modo de escrita que permite subescrever o que já existe
 
    if file then																			-- Se o arquivo estiver aberto
        file:write( json.encode( scoresTable ) )											-- Escreva as pontuações que estão na tabela de scores para o arquivo	
        io.close( file )																	-- Fecha o arquivo	
    end																					
end																						-- Fim da função

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

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
