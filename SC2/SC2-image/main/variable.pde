import ddf.minim.*;
Minim minim;
AudioPlayer music;
public boolean playmusic = false;

public ArrayList<Marin> marins;
public ArrayList<building> team1buildings;//ALLER LES BLEU
public ArrayList<building> team2buildings;//aller les rouge
public Marin marin;
public Terrain terrain;
public int block;
//int gamewidth = 7680,gameheight = 4320;
public int gamewidth,gameheight;
public int locationX,locationY;
public float spawntime;
public float gametime;

public boolean moveleft,moveright,moveup,movedown;
public boolean bigger,smaller;
public boolean victory1 = false,victory2 = false,gamefinished = false,alreadywin = false;

public int findunit;

public PImage marinstill,marinstill2;
