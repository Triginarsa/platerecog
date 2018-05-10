%CREATE TEMPLATES
%Letter
A=imread('datasets\A.bmp');B=imread('datasets\B.bmp');
C=imread('datasets\C.bmp');D=imread('datasets\D.bmp');
E=imread('datasets\E.bmp');F=imread('datasets\F.bmp');
G=imread('datasets\G.bmp');H=imread('datasets\H.bmp');
I=imread('datasets\I.bmp');J=imread('datasets\J.bmp');
K=imread('datasets\K.bmp');L=imread('datasets\L.bmp');
M=imread('datasets\M.bmp');N=imread('datasets\N.bmp');
O=imread('datasets\O.bmp');P=imread('datasets\P.bmp');
Q=imread('datasets\Q.bmp');R=imread('datasets\R.bmp');
S=imread('datasets\S.bmp');T=imread('datasets\T.bmp');
U=imread('datasets\U.bmp');V=imread('datasets\V.bmp');
W=imread('datasets\W.bmp');X=imread('datasets\X.bmp');
Y=imread('datasets\Y.bmp');Z=imread('datasets\Z.bmp');
%Number
one=imread('datasets\1.bmp');  two=imread('datasets\2.bmp');
three=imread('datasets\3.bmp');four=imread('datasets\4.bmp');
five=imread('datasets\5.bmp'); six=imread('datasets\6.bmp');
seven=imread('datasets\7.bmp');eight=imread('datasets\8.bmp');
nine=imread('datasets\9.bmp'); zero=imread('datasets\0.bmp');
%*-*-*-*-*-*-*-*-*-*-*-
letter=[A B C D E F G H I J K L M...
    N O P Q R S T U V W X Y Z];
number=[one two three four five...
    six seven eight nine zero];
character=[letter number];
templates=mat2cell(character,32,[16 16 16 16 16 16 16 ...
    16 16 16 16 16 16 16 ...
    16 16 16 16 16 16 16 ...
    16 16 16 16 16 16 16 ...
    16 16 16 16 16 16 16 16]);
save ('templates','templates')
%clear all
