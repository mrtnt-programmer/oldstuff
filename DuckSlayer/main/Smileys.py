########################################################################################emogie drawing#####################################################################################################
def drawDuckEmogie(x,y,largeur,hauteur):#x,y sont le centre
    Xcentre = x
    Ycentre = y
    strokeWeight(1)
    fill(0,200,40)
    ellipse(Xcentre,Ycentre,largeur,hauteur)
    
    #yeux 
    fill(255)
    ellipse(Xcentre-largeur/6,Ycentre-hauteur/12,largeur/5,hauteur/3)#left
    fill(0)
    ellipse(Xcentre-largeur/6,Ycentre-hauteur/12,largeur/9,hauteur/9)
    fill(255)
    ellipse(Xcentre+largeur/6,Ycentre-hauteur/12,largeur/5,hauteur/3)#right
    fill(0)
    ellipse(Xcentre+largeur/6,Ycentre-hauteur/12,largeur/9,hauteur/9)
    
    #bouche 
    fill(220,220,0)
    strokeWeight(1)
    ellipse(Xcentre,Ycentre+hauteur/5,largeur/2.8,hauteur/4)
    fill(230,230,0)
    ellipse(Xcentre,Ycentre+hauteur/5,largeur/2.8,hauteur/6)
    #nez
    fill(0)
    ellipse(Xcentre-largeur/12,Ycentre+hauteur/7,largeur/28,hauteur/16)
    ellipse(Xcentre+largeur/12,Ycentre+hauteur/7,largeur/28,hauteur/16)
    #save("smiley_1_Lamy_Naoki.jpg") 

def drawHeroEmogie(x,y,largeur,hauteur):#x,y sont le centre
    Xcentre = x
    Ycentre = y
    strokeWeight(1)
    fill(40,120,200)
    ellipse(Xcentre,Ycentre,largeur,hauteur)
    
    #yeux
    fill(255)
    ellipse(Xcentre-largeur/6,Ycentre-hauteur/12,largeur/5,hauteur/3)#left
    fill(149,69,53)
    ellipse(Xcentre-largeur/6,Ycentre-hauteur/12,largeur/9,hauteur/9)
    fill(255)
    ellipse(Xcentre+largeur/6,Ycentre-hauteur/12,largeur/5,hauteur/3)#right
    fill(149,69,53)
    ellipse(Xcentre+largeur/6,Ycentre-hauteur/12,largeur/9,hauteur/9)
    
    #sourcile
    noStroke()
    fill(10,60,200)
    beginShape();#left
    vertex(Xcentre-largeur/8,Ycentre-hauteur/2.6);#top left
    vertex(Xcentre-largeur/12,Ycentre-hauteur/2.6);#top right
    vertex(Xcentre-largeur/3,Ycentre-hauteur/6);#bottom 
    endShape(CLOSE);
    beginShape();#right
    vertex(Xcentre+largeur/8,Ycentre-hauteur/2.6);#top right
    vertex(Xcentre+largeur/12,Ycentre-hauteur/2.6);#top left
    vertex(Xcentre+largeur/3,Ycentre-hauteur/6);#bottom 
    endShape(CLOSE);
    
    #bouche
    noStroke()
    fill(10,60,200)
    ellipse(Xcentre,Ycentre+hauteur/3.4,largeur/2.6,hauteur/4)#left
    fill(40,120,200)
    ellipse(Xcentre,Ycentre+hauteur/3,largeur/2.6,hauteur/4)#left
    
    #glacon
    fill(60,160,220)
    glacon(Xcentre+largeur/2.3,Ycentre-hauteur/9, #bottom right
            Xcentre+largeur/2.7,Ycentre-hauteur/8,
            Xcentre+largeur/2.5,Ycentre+hauteur/3.8)
    glacon(Xcentre-largeur/2.3,Ycentre-hauteur/4, #bottom left
            Xcentre-largeur/2.7,Ycentre-hauteur/5,
            Xcentre-largeur/2.5,Ycentre+hauteur/6)
    glacon(Xcentre-largeur/8,Ycentre-hauteur/2.6, #top left
            Xcentre-largeur/12,Ycentre-hauteur/3.4,
            Xcentre-largeur/10,Ycentre-hauteur/20)
    
def glacon(X1,Y1,X2,Y2,X3,Y3):# 1,top left;2,top right;3,bottom
    triangle(X1,Y1,X2,Y2,X3,Y3)#base triangle
    
    push()#pour le fill(0)
    fill(60,140,230)
    diviseur = 10 #portion du glacon qui sera couvert
    beginShape();#degrade blanc
    vertex(X1,Y1);#top right
    vertex(X2,Y2);#top left
    vertex(X2-(X2-X3)/diviseur,Y2-(Y2-Y3)/diviseur);#bottom left
    vertex(X1-(X1-X3)/diviseur,Y1-(Y1-Y3)/diviseur);#bottom right
    endShape(CLOSE);
    pop()
    

def drawCivilEmogie(x,y,largeur,hauteur):#x,y sont le centre
    image(civilImage,x-largeur/2,y-hauteur/2,largeur,hauteur)
    
###############################################################################Smileys de Leo##########################################################################################

def drawEnnemie1(x,y,largeur,hauteur):
    push()
    translate(x,y)
    translate(-largeur,-hauteur)
    t = 1 * (largeur*2/500.0)
    scale(t)
    strokeWeight(7)
    fill(240,195,0)
    circle(250,250,400)
    strokeWeight(2)
    fill(255,128,0)
    arc(250,350,210,140,radians(0),radians(180),PIE)
    strokeWeight(3)
    fill(255)
    circle(170,235,100)
    circle(330,235,100)
    fill(0)
    circle(330,235,50)
    circle(170,235,50)
    bezier(120,150,50,130,170,170,200,190)
    bezier(380,150,450,130,330,170,300,190)
    h=165
    for d in range(1,7):
        noStroke()
        fill(255,255,255)
        rect(h,350,27,30)
        h=h+28
    pop()
    
def drawEnnemie2(x,y,largeur,hauteur):
    push()
    translate(x,y)
    translate(-largeur,-hauteur)
    t = 1 * (largeur*2/500.0)
    scale(t)
    strokeWeight(7)
    fill(240,195,0)
    circle(250,250,400)
    fill(0)
    ellipse(320,235,25,45) 
    ellipse(180,235,45,25) 
    line(200,300,320,300)
    bezier(120,150,50,130,170,170,200,190)
    bezier(380,150,350,130,330,170,300,150)
    pop()
