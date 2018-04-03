
PImage a;

void setup()
{
//puis on appelle notre image
//j'ai chois un joli soleil :p
a = loadImage("image.jpg");
//ensuite, on va régler la taille de la fenêtre avec la taille de l'image
//size(a.width, a.height);
size(3872,2592);
//puis on va positionner notre image en 0,0
image(a, 0, 0);

//et c'est là que get() entre en action
color aa = a.get(50,50); // je stocke ça dans une variable a de type couleur que j'ai ici initialisé
//comme vous pouvez le voir, on écrit ici b.get pour dire à Processing qu'il doit exécuter le get() dans l'image b
//maintenant, on va décomposer la couleur récupérée en RGB de la façon suivante :
float c = red(aa);
float d = blue(aa);
float e = green(aa);
//si vous utilisez int, vous allez avoir une erreur, car la couleur donnée sera décimale
//créons un petit tableau, histoire de faire ça proprement
float[] couleur_image = new float[3]; 
couleur_image[0] = c;
couleur_image[1] = d;
couleur_image[2] = e;
//voilà, il n'y a plus qu'à afficher
println(couleur_image);
}