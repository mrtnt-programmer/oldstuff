from Smileys import *

def setup():
    size(1024,600)
    #fullScreen()
    #declaration des variable apres le fullscreen(calcule en fonction de la largeur)
    global civilImage,heroTirsImage,miniMapImages,MenuImage
    civilImage = loadImage("civil.jpg")
    heroTirsImage = loadImage("hero-tirs\pixil-frame-0.png")
    #heroTirsImage.resize(100,100)#change la taille de l'image en (largeur,hauteur)
    #charge tous les images de miniMap 

    MenuImage = loadImage("Title.jpg")
    #MenuImage.resize(width,height)
    miniMapImages = {}
    miniMapTypes = ["Enemy","Boss","Chest","Home","Mystery"]

    for type in miniMapTypes:
        # on doit fair des acrobatie pour avoir "miniMap\" car la fin en \" ne compt pas comme "
        baseFile = "miniMap/ "
        baseFile = baseFile[0:-1]
        miniMapImage = loadImage(baseFile+type+".png")
        #miniMapImage.resize(20,20)
        miniMapImages[type] = miniMapImage
    global currentScreen
    currentScreen = "menu"# "menu" #le Menu, "Stage" #on joue , "gameover" #on a perdu , "settings" #le bouton pour fair une pause
    global lvl,finalLvl#ces variable sont pour les different niveau
    lvl = 0#montre sur quel niveau on est(niveau +1 quand on bat un boss)
    finalLvl = 3#quand on est sur ce niveau aux lieux de continuer on affiche l'ecrant de victoire
    start()#initialisation des variables                
            
def start():#tout les variables sont definies dans cette fonctions,elle est utilise pour commencer ou recommancer le jeu
    heroVariable()
    stageVariable()
    ennemiesVariable()
    
def draw():
    global lvl,currentScreen
    print(lvl,currentScreen)
    background(0)
    global currentScreen
    if currentScreen == "menu":
        menu()#affichage du menu
    elif currentScreen == "gameover":
        gameover()#affichage de l'ecran de fin de jeu(perdu)
    elif currentScreen == "playing":
        gameDrawing()#affichage du jeu(joue)
    elif currentScreen == "win":
        victoryScreen()#affichage de l'ecran de victoire(gagne)
        
def keyPressed():
    #detection du clavier 
    #pour le mouvement du hero
    global heroUp,heroDown,heroLeft,heroRight
    if(keyCode == UP):
        heroUp = True
    if(keyCode == LEFT):
        heroLeft = True
    if(keyCode == DOWN):
        heroDown = True
    if(keyCode == RIGHT):
        heroRight = True
    #pour les tirs du hero
    global heroShooting
    if(key == " "):
        heroShooting = True
        
def keyReleased():
    #detection du relachement des touches du clavier 
    #pour le mouvement du hero
    global heroUp,heroDown,heroLeft,heroRight
    if(keyCode == UP):
        heroUp = False
    if(keyCode == LEFT):
        heroLeft = False
    if(keyCode == DOWN):
        heroDown = False
    if(keyCode == RIGHT):
        heroRight = False
    #pour les tirs du hero
    global heroShooting
    if(key == " "):
        heroShooting = False
        
################################################################################################################################################################################

#dessin, mouvement et actualisation de l'ecrant (soit stage+bar d'info,menu,gameover,settings,victoire)

################################################################################################################################################################################

def stageVariable():
    global lvl
    #variable pour la zone de combat
    global stagesInfo,currentStageCoor
    stagesInfo = []#la list de la map avec chaque salle
    stageHauteur = 6
    stageLargeur = 6
    #construction de la list "stagesInfo"
    for c in range(stageLargeur):
        colonne = []
        for l in range(stageHauteur):
            #le type de stage, le stage est vide(monstre sont mort), avons nous pris les recompenses, 
            #V = vide , S = start ,E = combat, B = boss , C = chest , M = marchand  # "cleared" "fighting" ou un nombre qui sera le nombre d'ennimes a spawn
            colonne.append(["V","cleared",False])
        stagesInfo.append(colonne)
    #pour les modification, stagesInfo[x][y][info a changer] = ...
    #ou stagesInfo[x][y] = [info1,info2,...]
    if lvl == 0 :
        stagesInfo[0][1] = ["S","cleared",False]
        stagesInfo[1][1] = ["B",1,False]
    elif lvl == 1 :
        stagesInfo[0][1] = ["S","cleared",False]
        stagesInfo[1][0] = ["C","cleared",False]
        stagesInfo[1][1] = ["E",4,False]
        stagesInfo[1][2] = ["C","cleared",False]
        stagesInfo[2][1] = ["B",1,False]
    elif lvl == 2 :
        stagesInfo[0][0] = ["C","cleared",False]
        stagesInfo[1][0] = ["E",4,False]
        stagesInfo[2][0] = ["C",8,False]
        stagesInfo[3][0] = ["C",12,False]
        stagesInfo[4][0] = ["C",18,False]
        
        stagesInfo[1][1] = ["E",7,False]
        stagesInfo[3][1] = ["C","cleared",False]
        
        stagesInfo[1][2] = ["E",3,False]
        stagesInfo[4][2] = ["C","cleared",False]

        stagesInfo[0][3] = ["S","cleared",False]
        stagesInfo[1][3] = ["E",6,False]
        stagesInfo[2][3] = ["E",12,False]
        stagesInfo[3][3] = ["E",16,False]
        stagesInfo[4][3] = ["E",24,False]
        
        stagesInfo[2][4] = ["E",2,False]
        stagesInfo[4][4] = ["C","cleared",False]

        stagesInfo[0][5] = ["B",1,False]
        stagesInfo[1][5] = ["C",40,False]
        stagesInfo[2][5] = ["E",12,False]        
        
    currentStageCoor = [0,1]#les coordonnes du stage auquelle nous somme dans la list stagesInfo
    for c in range(stageLargeur):
        for l in range(stageHauteur):
            if stagesInfo[c][l][0] == "S":
                currentStageCoor = [c,l]#les coordonnes du stage auquelle nous somme dans la list stagesInfo
    
    global stageDoor
    #left,right,top,bottom
    stageDoor = [False,False,False,False]
    doorRefresh()#actualise les portes pour aller dans une autre salle
    global marge
    marge = 30#marge entre les limites de l'ecrant et le terran de combat
    #les variable  d'affichage pour le terran de combat
    global combatAreaX,combatAreaY,combatAreaW,combatAreaH
    combatAreaX = marge
    combatAreaY = marge
    combatAreaW = width-marge*2
    combatAreaH = height*2/3-marge*2
    
    #variable d'affichage pour la bar d'info
    global barInfoX,barInfoY,barInfoW,barInfoH
    barInfoX = 0
    barInfoY = height*2/3
    barInfoW = width
    barInfoH = height/3
    
    global doorSize
    doorSize = 100
        
def gameDrawing():
    global stagesInfo,currentStageCoor
    currentStageType = stagesInfo[currentStageCoor[0]][currentStageCoor[1]][0]
    doorChange()
    if currentStageType == "S":#zone de debut
        drawCombatArea()
        drawHero()#affichage du hero
        HeroRefresh()#creation,actualisation,et destruction des tirs du hero 
        heroMouvement()#mouvement et collison du hero
        drawBar()
        fill(0)
        text("start",width/2,height/2)
       
    elif currentStageType == "B":#salle de boss
        drawCombatArea()
        ennemiesDraw()#affichage de l'ennemies
        ennemiesRefresh()#creation,actualisation,et destruction des tirs , et destruction des ennemies
        ennemiesMouvement()#mouvement et collison des ennemies
        drawHero()#affichage du hero
        HeroRefresh()#creation,actualisation,et destruction des tirs du hero 
        heroMouvement()#mouvement et collison du hero

        drawBar()
        fill(0)
        text("boss",width/2,height/2)
        
    if currentStageType == "C":#salle de coffre 
        drawCombatArea()
        
        drawHero()#affichage du hero
        HeroRefresh()#creation,actualisation,et destruction des tirs du hero 
        heroMouvement()#mouvement et collison du hero

        drawBar()
        fill(0)
        text("chest",width/2,height/2)
        
    elif currentStageType == "E":#salle de combat
        drawCombatArea()#affichage de la zone de combat
        
        ennemiesDraw()#affichage de l'ennemies
        ennemiesRefresh()#creation,actualisation,et destruction des tirs , et destruction des ennemies
        ennemiesMouvement()#mouvement et collison des ennemies
    
        drawHero()#affichage du hero
        HeroRefresh()#creation,actualisation,et destruction des tirs du hero 
        heroMouvement()#mouvement et collison du hero
        
        #information divers dans le 1/3 bas(minimap,vie et mana du hero,inventaire du hero)
        drawBar()
        fill(0)
        text("combat",width/2,height/2)

    elif currentStageType == "V":#salle qui n'exist pas (pour debug)
        fill(255)
        text("vide",width/2,height/2)
    print("ok")

def menu():#affichage du menu
    global currentScreen
    global MenuImage
    background(0)
    textAlign(CENTER,CENTER);
    textSize(60)
    fill(0,0,255)
    image(MenuImage,0,0)#l'image n'est pas transparent donc on doit ecrire le text dessus
    text("WELCOME TO",width/2,height/16)
    #construction du bouton pour commencer le jeu
    pressed = button(width/2,height/2,width/12,height/12,"START",color(0,0,255),color(45))
    if (pressed):
        start()
        currentScreen = "playing"
        
def gameover():#ecrant de fin de jeu
    global currentScreen
    background(0)
    textAlign(CENTER,CENTER);
    textSize(80)
    text("GAMEOVER",width/2,height/6)
    #bouton pour commencer le jeu
    pressed = button(width/2,height/2,width/12,height/12,"RESTART",color(0,0,255),color(45))
    if (pressed):
        start()
        currentScreen = "playing"
    #bouton pour revenir au menu
    pressed = button(width/2,height/2+height/10,width/12,height/12,"MENU",color(0,0,255),color(45))
    if (pressed):
        start()
        currentScreen = "menu"
        
def victoryScreen():#ecrant de victoir
    global currentScreen
    background(0)
    textAlign(CENTER,CENTER);
    textSize(80)
    text("YOU WIN",width/2,height/6)
    #bouton pour commencer le jeu
    pressed = button(width/2,height/2,width/12,height/12,"RESTART",color(0,0,255),color(45))
    if (pressed):
        start()
        currentScreen = "playing"
    #bouton pour revenir au menu
    pressed = button(width/2,height/2+height/10,width/12,height/12,"MENU",color(0,0,255),color(45))
    if (pressed):
        start()
        currentScreen = "menu"
 
#affichage d'un bouton et retourne si ce bouton a ete appuyer
def button(X,Y,W,H,T,C,BC):#X,Y,Width,height,text,color,backgroundColor
    fill(BC)
    rect(X,Y,W,H)
    fill(C)
    textAlign(CENTER,CENTER);
    textSize(18)
    text(T,X+W/2,Y+H/2)
    #si on appuye sur le bouton on commance le jeu
    if(mouseX>X and mouseX<X+W and mouseY>Y and mouseY<Y+H and mousePressed):
        return True
    return False

def drawCombatArea():#la zone de combat
    global stagesInfo,currentStageCoor
    global doorSize
    global combatAreaX,combatAreaY,combatAreaW,combatAreaH
    global gold
    fill(230)
    rect(combatAreaX,combatAreaY,combatAreaW,combatAreaH)#zone de combat
    fill(180)
    # la quantite de "gold" qu'a le hero
    fill(255)
    text("gold:"+str(gold),combatAreaX+combatAreaW*9/10,combatAreaY*1/2)
    #les portes pour changer de salle
    global stageDoor
    #left
    if stageDoor[0]:
        rect(combatAreaX-marge,combatAreaY+combatAreaH/2-doorSize/2,marge,doorSize)
    #right
    if stageDoor[1]:
        rect(combatAreaX+combatAreaW,combatAreaY+combatAreaH/2-doorSize/2,marge,doorSize)
    #top
    if stageDoor[2]:
        rect(combatAreaX+combatAreaW/2-doorSize/2,combatAreaY-marge,doorSize,marge)
    #bottom
    if stageDoor[3]:
        rect(combatAreaX+combatAreaW/2-doorSize/2,combatAreaY+combatAreaH,doorSize,marge)
    
def drawBar():#la bar d'information

    global barInfoX,barInfoY,barInfoW,barInfoH
    barMargin = 10
    fill(60)
    rect(barInfoX,barInfoY,barInfoW,barInfoH)
    #minimap   on ne montre seulement les stages qui sont autour de nous(donc dans un 3X3)
    fill(255)
    rect(barInfoX,barInfoY,barInfoW*1/5,barInfoH)#background
    global stagesInfo,currentStageCoor
    global miniMapImages
    minimapMargin = 10
    minimapStageW = ((barInfoW*1/5)-(4*minimapMargin))/3
    minimapStageH = (barInfoH-(4*minimapMargin))/3
    for c in range(-1,2):
        for l in range(-1,2):
            if currentStageCoor[0] + c >= 0 and currentStageCoor[0] + c < len(stagesInfo) and currentStageCoor[1] + l >= 0 and currentStageCoor[1] + l < len(stagesInfo[0]):
                currentStageType = stagesInfo[currentStageCoor[0]+c][currentStageCoor[1]+l][0]
                if currentStageType != "V":
                    fill(120)
                    rect(barInfoX+minimapMargin + (c+1) *(minimapMargin+minimapStageW),barInfoY+minimapMargin + (l+1) *(minimapMargin+minimapStageH),minimapStageW,minimapStageH)
                    #une lettre pour savoir ce que est le stage
                    #fill(0)
                    #text(stagesInfo[currentStageCoor[0]+c][currentStageCoor[1]+l][0],barInfoX+minimapMargin + (c+1) * (minimapMargin+minimapStageW),barInfoY+minimapMargin + (l+1) * (minimapMargin+minimapStageH),minimapStageW,minimapStageH)
                    #mantenant c'est des images
                    miniMapImage = 0
                    if currentStageType == "B":
                        miniMapImage = miniMapImages["Boss"]
                    elif currentStageType == "E":
                        miniMapImage = miniMapImages["Enemy"]
                    elif currentStageType == "C":
                        miniMapImage = miniMapImages["Chest"]
                    elif currentStageType == "S":
                        miniMapImage = miniMapImages["Home"]

                    if miniMapImage != 0:
                        image(miniMapImage,barInfoX+minimapMargin + (c+1.33) * (minimapMargin+minimapStageW),barInfoY+minimapMargin + (l+1.33) * (minimapMargin+minimapStageH),20,20)

    #life,mana,name data
    global totalLife,totalMana,life,mana
    X = barInfoX+barInfoW*1/5+barMargin
    Y = barInfoY
    W = barInfoW*3/5-barMargin*2
    H = barInfoH
    vitalBar(X + W/4,Y+W/12,W/2,H/8,color(255,0,0),totalLife,life)#bar de hp
    vitalBar(X + W/3,Y+W/7,W/3,H/10,color(0,0,255),totalMana,mana)#bar de mana
    
    #controll info(on how to play)
    fill(255)
    rect(barInfoX+barInfoW*4/5,barInfoY,barInfoW*1/5,barInfoH)
    
def vitalBar(X,Y,W,H,colorVital,totalVital,vital):#les bar d'HP
    #background
    fill(0)
    rect(X,Y,W,H)
    #bar en couleur qui montre la quantite de vital
    fill(colorVital)
    vitalBarW = W * vital/totalVital
    rect(X,Y,vitalBarW,H)
        
def doorRefresh():#verifie si il a des salle a cote et stock cette info dans la list stageDoor
    global stageDoor
    global stagesInfo,currentStageCoor
    currentStageType = stagesInfo[currentStageCoor[0]][currentStageCoor[1]][0]
    #remettre la variable a 0
    stageDoor = [False,False,False,False]
    if currentStageCoor[0] > 0:#left
        if stagesInfo[currentStageCoor[0]-1][currentStageCoor[1]][0] != "V":
            stageDoor[0] = True
    if currentStageCoor[0] < len(stagesInfo)-1 :#right
        if stagesInfo[currentStageCoor[0]+1][currentStageCoor[1]][0] != "V":
            stageDoor[1] = True
    if currentStageCoor[1] > 0:#top
        if stagesInfo[currentStageCoor[0]][currentStageCoor[1]-1][0] != "V":
            stageDoor[2] = True
    if currentStageCoor[1] < len(stagesInfo[0])-1 :#bottom
        if stagesInfo[currentStageCoor[0]][currentStageCoor[1]+1][0] != "V":
            stageDoor[3] = True
    
def doorChange():
    global heroVitesseMax
    global heroX,heroY,heroSize
    global heroUp,heroDown,heroLeft,heroRight
    global combatAreaX,combatAreaY,combatAreaW,combatAreaH
    global currentStageCoor
    global stageDoor
    global stagesInfo
    if stagesInfo[currentStageCoor[0]][currentStageCoor[1]][1] == "cleared":#si il n'a pas du combat on peux utiliser les portes
        #on verifie les collisions avec les portes, si on touche l'un d'eux on change de stage
        if stageDoor[0]:#left
            if heroX > combatAreaX and heroX < combatAreaX+heroSize+heroVitesseMax+1 and heroY > combatAreaY+combatAreaH/2-doorSize/2 and heroY < combatAreaY+combatAreaH/2+doorSize/2 and heroLeft:
                currentStageCoor[0] -=1
                doorRefresh()
                heroX = combatAreaX+combatAreaW-2
                checkNewStage()

        if stageDoor[1]:#right
            if heroX < combatAreaX+combatAreaW and heroX > combatAreaX+combatAreaW-heroSize-heroVitesseMax-1 and heroY > combatAreaY+combatAreaH/2-doorSize/2 and heroY < combatAreaY+combatAreaH/2+doorSize/2 and heroRight:
                currentStageCoor[0] +=1
                doorRefresh()
                heroX = combatAreaX+2
                checkNewStage()
                
        if stageDoor[2]:#top
            if heroX > combatAreaX+combatAreaW/2-doorSize/2 and heroX < combatAreaX+combatAreaW/2+doorSize/2 and heroY > combatAreaY and heroY < combatAreaY+heroSize+heroVitesseMax+1 and heroUp:
                currentStageCoor[1] -=1
                doorRefresh()
                heroY = combatAreaY+combatAreaH-2
                checkNewStage()
        
        if stageDoor[3]:#bottom
            if heroX > combatAreaX+combatAreaW/2-doorSize/2 and heroX < combatAreaX+combatAreaW/2+doorSize/2 and heroY > combatAreaY+combatAreaH-heroSize-heroVitesseMax-1 and heroY < combatAreaY+combatAreaH and heroDown:
                currentStageCoor[1] +=1
                doorRefresh()
                heroY = combatAreaY+2
                checkNewStage()
    else:#si il a du combat on verifie si il a toujours des ennemies
        if len(ennemiesX) == 0:
            stagesInfo[currentStageCoor[0]][currentStageCoor[1]][1] = "cleared"
            if stagesInfo[currentStageCoor[0]][currentStageCoor[1]][0] == "B":#si on tue le boss on pass au prochain niveau
                global lvl,finalLvl,currentScreen
                lvl += 1
                if lvl == finalLvl:#si on depasse le niveau final,on a gagne
                    currentScreen = "win"
                else:#sinon on recommence
                    start()
                
def checkNewStage():#prepare le nouveau stage(suprime les tirs du hero, spawn les ennemies si besoin)
    global currentStageCoor
    global stagesInfo
    global TirsHero
    TirsHero = []
    currentStageType = stagesInfo[currentStageCoor[0]][currentStageCoor[1]][0] 
    currentStageStatus = stagesInfo[currentStageCoor[0]][currentStageCoor[1]][1] 
    if currentStageType == "E": #verifie si on doit commencer un combat
        if currentStageStatus != "cleared" and currentStageStatus != "fighting":
            ennemiesProduction(currentStageStatus)
            stagesInfo[currentStageCoor[0]][currentStageCoor[1]][1] = "fighting"
    elif currentStageType == "B": #verifie si on doit commencer un combat de boss
        if currentStageStatus != "cleared" and currentStageStatus != "fighting":
            bossProduction(currentStageStatus)
            stagesInfo[currentStageCoor[0]][currentStageCoor[1]][1] = "fighting"
            
########################################################################################################################################################################################

#ennemies,tirs des ennemies 

########################################################################################################################################################################################
def ennemiesVariable():#variable pour les ennemies, generalement ce sont des lists car on doit pouvoir les cloner
    #les coordonne des ennemies
    global ennemiesX,ennemiesY,ennemiesSize
    ennemiesX = []
    ennemiesY = []
    ennemiesSize = width/36
    #la vitesse des ennemies
    global ennemiesVitesseX,ennemiesVitesseY
    ennemiesVitesseX = []
    ennemiesVitesseY = []
    #les variables des tirs des ennemies
    global TirsEnnemies,intervalEnnemies
    TirsEnnemies = [[]]
    intervalEnnemies = []
    global vitesseDeTirsEnnemies
    vitesseDeTirsEnnemies = 10
    #la vie des ennemies + si c'est un boss(pour l'affichage)
    global ennemiesHP,ennemiesMaxHp
    ennemiesHP = []
    ennemiesMaxHp = 1
    isBoss = False

def ennemiesProduction(nbrEnnemies):#on produit "nbrEnnemies" de ennemies 
    global ennemiesX,ennemiesY,ennemiesSize
    global ennemiesVitesseX,ennemiesVitesseY
    global TirsEnnemies,intervalEnnemies
    global combatAreaX,combatAreaY,combatAreaW,combatArea
    global ennemiesHP,ennemiesMaxHp
    global isBoss
    isBoss = False
    #initialisation des list avec le nombre d'ennemie a cree 
    ennemiesX = nbrEnnemies*[0]
    ennemiesY = nbrEnnemies*[0]
    ennemiesVitesseX = nbrEnnemies*[5]
    ennemiesVitesseY = nbrEnnemies*[5]
    intervalEnnemies = nbrEnnemies*[0]
    ennemiesHP = nbrEnnemies*[ennemiesMaxHp]
    #ici j'utilise append car je ne connais pas d'autre facon pour fair une list dans une list
    for i in range(nbrEnnemies):
        TirsEnnemies.append([])
        ennemiesX[i] = (random(combatAreaX,combatAreaX + combatAreaW))
        ennemiesY[i] = (random(combatAreaY,combatAreaY + combatAreaH))
        
def bossProduction(nbrBoss):
    global ennemiesX,ennemiesY,ennemiesSize
    global ennemiesVitesseX,ennemiesVitesseY
    global TirsEnnemies,intervalEnnemies
    global combatAreaX,combatAreaY,combatAreaW,combatArea
    global ennemiesHP,ennemiesMaxHp
    global isBoss
    isBoss = True
    ennemiesX = nbrBoss*[0]
    ennemiesY = nbrBoss*[0]
    ennemiesVitesseX = nbrBoss*[5]
    ennemiesVitesseY = nbrBoss*[5]
    intervalEnnemies = nbrBoss*[0]
    ennemiesHP = nbrBoss*[ennemiesMaxHp*5]
    for i in range(nbrBoss):
        TirsEnnemies.append([])
        ennemiesX[i] = (random(combatAreaX,combatAreaX + combatAreaW))
        ennemiesY[i] = (random(combatAreaY,combatAreaY + combatAreaH))

def ennemiesDraw():#affichage des ennemies
    global ennemiesX,ennemiesY,ennemiesSize
    global isBoss
    for i in range(len(ennemiesX)):
        #si c'est un boss on affiche un canard
        if isBoss:
            drawDuckEmogie(ennemiesX[i],ennemiesY[i],ennemiesSize*2,ennemiesSize*2)
        #sinon l'emogie classic
        else:
            drawEnnemie1(ennemiesX[i],ennemiesY[i],ennemiesSize/1.4,ennemiesSize/1.4)
        
def ennemiesRefresh():
    global TirsEnnemies,intervalEnnemies
    global vitesseDeTirsEnnemies
    global ennemiesHP
    # on parcoure la list a l'envers pour que quand on enleve une variable cela n'explose pas
    for i in range(len(ennemiesX)-1,-1,-1):
        if intervalEnnemies[i] >= vitesseDeTirsEnnemies:
            tirsProduction(i)
            intervalEnnemies[i] = 0
        else:
            intervalEnnemies[i] += 1
        tirsDraw(i)
        tirsMouvement(i)
        
        if ennemiesHP[i] <= 0:#on supprime l'ennmies si il est mort
            ennemiesX.remove(ennemiesX[i])
            ennemiesY.remove(ennemiesY[i])
            ennemiesVitesseX.remove(ennemiesVitesseX[i])
            ennemiesVitesseY.remove(ennemiesVitesseY[i])
            TirsEnnemies.remove(TirsEnnemies[i])
            intervalEnnemies.remove(intervalEnnemies[i]) 
            ennemiesHP.remove(ennemiesHP[i])
            #le hero gagne du "gold" quand il tue un ennemies
            global gold
            gold += 5
   
def ennemiesMouvement():
    global ennemiesX,ennemiesY,ennemiesSize
    global ennemiesVitesseX,ennemiesVitesseY
    global combatAreaX,combatAreaY,combatAreaW,combatArea
    #on bouge les cordonne selon la vitesse
    for i in range(len(ennemiesX)):
        ennemiesX[i] += ennemiesVitesseX[i]
        ennemiesY[i] += ennemiesVitesseY[i]
    detectionMursEnnemie()#on regarde si les ennemies ont touche un murs(et donc doivent rebondire)
    ennemiesCollison()#collison avec les tirs du hero et le hero

def ennemiesCollison():
    global heroX,heroY,heroSize
    global ennemiesX,ennemiesY,ennemiesSize
    global TirsHero
    global ennemiesHP
    for i in range(len(ennemiesX)):
        #test de collision avec le corps du hero
        if (sqrt((heroX-ennemiesX[i])*(heroX-ennemiesX[i]) + (heroY-ennemiesY[i])*(heroY-ennemiesY[i])) < heroSize+ennemiesSize):
            ennemiesHP[i] -= 1
        #test de collision avec les tirs du hero
        for c in range(len(TirsHero)):
            if (sqrt((ennemiesX[i]-TirsHero[c][0])*(ennemiesX[i]-TirsHero[c][0]) + (ennemiesY[i]-TirsHero[c][1])*(ennemiesY[i]-TirsHero[c][1])) < ennemiesSize+TirsHero[c][4]):
                ennemiesHP[i] -= 1

def detectionMursEnnemie():
    global ennemiesX,ennemiesY,ennemiesSize
    global ennemiesVitesseX,ennemiesVitesseY
    global combatAreaX,combatAreaY,combatAreaW,combatArea
    for i in range(len(ennemiesX)):
        #collision du murs droit et gauche
        if ennemiesX[i] + ennemiesSize/2 > combatAreaX + combatAreaW and ennemiesVitesseX[i] > 0 or ennemiesX[i] - ennemiesSize/2 < combatAreaX and ennemiesVitesseX[i] < 0:
            ennemiesVitesseX[i] = -ennemiesVitesseX[i]
        #collision du murs haut et bas
        if ennemiesY[i] + ennemiesSize/2 > combatAreaY + combatAreaH and ennemiesVitesseY[i] > 0 or ennemiesY[i] - ennemiesSize/2 < combatAreaY and ennemiesVitesseY[i] < 0:
            ennemiesVitesseY[i] = -ennemiesVitesseY[i]
            
def tirsProduction(ID):#ajout un tirs a un ennemie, ID c'est l'index de l'ennemie
    global ennemiesX,ennemiesY,ennemiesSize
    global ennemiesVitesseX,ennemiesVitesseY
    global TirsEnnemies
    #X,Y,Size,VitesseX,VitesseY,duree de vie(en nombre de rebond sur un mur),mort(si on doit ne plus afficher)
    TirsEnnemies[ID].append([ennemiesX[ID],ennemiesY[ID],5,ennemiesVitesseX[ID] + random(-3,3),ennemiesVitesseY[ID] + random(-3,3),2,False])

def tirsDraw(ID):#affichage de tous les tirs de l'ennemie ID
    global TirsEnnemies
    for i in range(len(TirsEnnemies[ID])):
        fill(255,0,0)
        circle(TirsEnnemies[ID][i][0],TirsEnnemies[ID][i][1],TirsEnnemies[ID][i][2])
        
def tirsMouvement(ID):#mouvement des tirs
    global TirsEnnemies
    for i in range(len(TirsEnnemies[ID])-1,-1,-1):#travers la list dans le sens opposee comme ca si on enleve une variable les index sont les meme(et ca plante pas)
        if TirsEnnemies[ID][i][6]:
            #si il a rebondi trop de fois, on suprimme
            TirsEnnemies[ID].remove(TirsEnnemies[ID][i])
        else:
            #sinon on continue a bouger
            TirsEnnemies[ID][i][0] += TirsEnnemies[ID][i][3]
            TirsEnnemies[ID][i][1] += TirsEnnemies[ID][i][4]
            tirsDetectionEnnemie(ID,i)
            
def tirsDetectionEnnemie(ID,i):#detection de si on touche un murs
    global TirsEnnemies
    global combatAreaX,combatAreaY,combatAreaW,combatArea
    if TirsEnnemies[ID][i][0] + TirsEnnemies[ID][i][2]/2 > combatAreaX + combatAreaW  or TirsEnnemies[ID][i][0] - TirsEnnemies[ID][i][2]/2 < combatAreaX :
        TirsEnnemies[ID][i][3] = -TirsEnnemies[ID][i][3]
        TirsEnnemies[ID][i][5] -= 1
    if TirsEnnemies[ID][i][1] + TirsEnnemies[ID][i][2]/2 > combatAreaY + combatAreaH  or TirsEnnemies[ID][i][1] - TirsEnnemies[ID][i][2]/2 < combatAreaY :
        TirsEnnemies[ID][i][4] = -TirsEnnemies[ID][i][4]
        TirsEnnemies[ID][i][5] -= 1
    if TirsEnnemies[ID][i][5] <= 0 and TirsEnnemies[ID][i][6] == False:
        TirsEnnemies[ID][i][6] = True

########################################################################################hero#####################################################################################################

def heroVariable():
    #les coordonnees du hero
    global heroX,heroY,heroSize
    heroX = width/3
    heroY = height/2
    heroSize = width/28
    global heroTirsImage
    global heroUp,heroDown,heroLeft,heroRight,heroVitesseMax
    #les variables de mouvement du hero
    heroUp = False
    heroDown = False
    heroLeft  = False
    heroRight = False
    heroVitesseMax = 5
    global totalLife,totalMana,life,mana,gold
    #les ressources/vitales du hero
    totalLife = 10
    totalMana = 100
    life = totalLife
    mana = totalMana
    gold = 0
    #variable de tirs/collision de tirs
    global invulnerabilitTime
    invulnerabilitTime = 30 #nombre de frame que le hero ne peux plus perdre de vie
    global TirsHero,intervalHero,heroShooting
    heroShooting = False
    TirsHero = []
    intervalHero = 0
    global vitesseDeTirsHero
    vitesseDeTirsHero = 10

def drawHero():#affichage du hero
    global heroX,heroY,heroSize
    drawHeroEmogie(heroX,heroY,heroSize,heroSize)
        
def heroMouvement():#mouvement et collision du hero
    global heroUp,heroDown,heroLeft,heroRight,heroVitesseMax
    global heroX,heroY,heroSize
    global combatAreaX,combatAreaY,combatAreaW,combatAreaH
    if(heroUp == True and heroY-heroSize/2>combatAreaY):
        heroY = heroY - heroVitesseMax
    if(heroDown == True and heroY+heroSize/2<combatAreaY+combatAreaH):
        heroY = heroY + heroVitesseMax
    if(heroLeft == True and heroX-heroSize/2>combatAreaX):
        heroX = heroX - heroVitesseMax
    if(heroRight == True and heroX+heroSize/2<combatAreaX+combatAreaW):
        heroX = heroX + heroVitesseMax
    heroCollison()
    
def heroCollison():#test de collision du hero
    global heroX,heroY,heroSize
    global ennemiesX,ennemiesY,ennemiesSize
    global TirsEnnemies
    global totalLife,totalMana,life,mana
    global invulnerabilitTime
    # il a un temp d'invulnerabite quand on se fait touche par une balle
    if invulnerabilitTime>0:
        invulnerabilitTime -= 1
    else:
        for i in range(len(ennemiesX)):
            #collision avec le corps des ennemies
            if (sqrt((heroX-ennemiesX[i])*(heroX-ennemiesX[i]) + (heroY-ennemiesY[i])*(heroY-ennemiesY[i])) < heroSize+ennemiesSize):
                life -= 1
                invulnerabilitTime = 30
            #collision avec les tirs des ennemies
            for c in range(len(TirsEnnemies[i])):
                if (sqrt((heroX-TirsEnnemies[i][c][0])*(heroX-TirsEnnemies[i][c][0]) + (heroY-TirsEnnemies[i][c][1])*(heroY-TirsEnnemies[i][c][1])) < heroSize+TirsEnnemies[i][c][4]):
                    life -= 1
                    invulnerabilitTime = 30
    
def HeroRefresh():#verification si on est toujours vivant + actualisation des tirs du hero
    global TirsHero,intervalHero
    global vitesseDeTirsHero,heroShooting
    global totalLife,totalMana,life,mana
    global currentScreen
    if intervalHero >= vitesseDeTirsHero and heroShooting:
        tirsProductionHero()
        intervalHero = 0
    else:
        intervalHero += 1
    tirsDrawHero()
    tirsMouvementHero()
    if life <= 0:
        currentScreen = "gameover"

def tirsProductionHero():#ajout un tirs
    global heroX,heroY,heroSize
    global heroUp,heroDown,heroLeft,heroRight,heroVitesseMax
    global TirsHero
    global mana
    tirsVitesseX,tirsVitesseY = tirsDetectionEnnemies()
    #X,Y,Size,VitesseX,VitesseY,duree de vie(en nombre de rebond sur un mur),mort(si on doit ne plus afficher)
    if mana > 0:
        TirsHero.append([heroX,heroY,5,tirsVitesseX,tirsVitesseY,2,False])
        mana = mana-1

def tirsDetectionEnnemies():#retourn une list [tirsVitesseX,tirsVitesseY] pour unne vitesse entre 0 et heroVitesseMax pour aller vers l'ennemies le plus proche
    global heroX,heroY,heroSize
    global ennemiesX,ennemiesY,ennemiesSize
    global heroVitesseMax

    if (len(ennemiesX) == 0):#si il na pas d'ennemie
        speed = [heroVitesseMax,0]#le hero tirs tout droit
        return speed
    else:
        smallestDistance = sqrt((heroX-ennemiesX[0])*(heroX-ennemiesX[0]) + (heroY-ennemiesY[0])*(heroY-ennemiesY[0])) < heroSize+ennemiesSize
        smallestDistanceID = 0
        for i in range(len(ennemiesX)):
            newDistance = sqrt((heroX-ennemiesX[i])*(heroX-ennemiesX[i]) + (heroY-ennemiesY[i])*(heroY-ennemiesY[i]))
            if  newDistance < smallestDistance :
                smallestDistance = newDistance
                smallestDistanceID = i

        speed = speedFormula(heroX,heroY,ennemiesX[smallestDistanceID],ennemiesY[smallestDistanceID],heroVitesseMax)
        return speed
        #formule pour les vitess a fair

def speedFormula(X1,Y1,X2,Y2,VMax):#pour un tirs qui va de X1 vers X2 en ligne droite a une vitesse maximale
    Vx = VMax
    Vy = 0
    if abs(X1-X2) > abs(Y1-Y2):#la vitess max sera en X(honrizontale)
        if X1-X2 > 0:#left 
            Vx = -VMax
            Vy = -VMax*(Y1-Y2)/(X1-X2)
        else:#right
            Vx = VMax
            Vy = VMax*(Y1-Y2)/(X1-X2)
    else:#la vitess max sera en Y
        if Y1-Y2 > 0:#top 
            Vx = -VMax*(X1-X2)/(Y1-Y2)
            Vy = -VMax
        else :#bottom
            Vx = VMax*(X1-X2)/(Y1-Y2)
            Vy = VMax
            
    return Vx,Vy

def tirsDrawHero():    
    global TirsHero
    for i in range(len(TirsHero)):
        fill(0,0,255)
        #circle(TirsHero[i][0],TirsHero[i][1],TirsHero[i][2])
        push()#creation d'une matrix pour que les fonctions translate et rotate n'affect pas le rest du code
        translate(TirsHero[i][0],TirsHero[i][1])
        rotate(0)
        circle(0,0,10)
        pop()

def tirsMouvementHero():
    global TirsHero
    for i in range(len(TirsHero)-1,-1,-1):#travers la list dans le sens opposee comme ca si on enleve une variable les index sont les meme
        if TirsHero[i][6]:
            TirsHero.remove(TirsHero[i])
        else:
            TirsHero[i][0] += TirsHero[i][3]
            TirsHero[i][1] += TirsHero[i][4]
            tirsDetectionCollisonMurs(i)

def tirsDetectionCollisonMurs(i):#test si les tirs ont une collision avec le murs(et donc vont rebondire)
    global TirsHero
    global combatAreaX,combatAreaY,combatAreaW,combatArea
    if TirsHero[i][0] + TirsHero[i][2]/2 > combatAreaX + combatAreaW  or TirsHero[i][0] - TirsHero[i][2]/2 < combatAreaX :
        TirsHero[i][3] = -TirsHero[i][3]
        TirsHero[i][5] -= 1
    if TirsHero[i][1] + TirsHero[i][2]/2 > combatAreaY + combatAreaH  or TirsHero[i][1] - TirsHero[i][2]/2 < combatAreaY :
        TirsHero[i][4] = -TirsHero[i][4]
        TirsHero[i][5] -= 1
    if TirsHero[i][5] <= 0 and TirsHero[i][6] == False:
        TirsHero[i][6] = True
                                    
