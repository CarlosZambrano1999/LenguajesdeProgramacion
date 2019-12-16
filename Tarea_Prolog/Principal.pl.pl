:- dynamic(alumno/5).
:- dynamic(clase/4).
:- dynamic(clase/3).
:- dynamic(clasecurs/4).

alumno(1,alex_reyes,20161002570,is,masculino).
alumno(2,carlos_zambrano,20161006197,is,masculino).

clase(1,is,programacionII,is210).
clase(2,is,algoritmos,is310).
clase(3,is,poo,is401).
clase(4,is,lenguajesDePro,is410).
clase(5,is,redesI,511).
clase(1,iq,quimicaOrganicaI,iq313).
clase(2,iq,termodinamica1,iq322).
clase(3,iq,cineticaAplicada,iq512).
clase(4,iq,procesosAmaliticos,iq300).
clase(5,iq,procesosIndustriales,iq415).

clasecurs(1,20161002570,is210,98).
clasecurs(2,20161002570,is401,76).
clasecurs(1,20161006197,is401,85).


listar_alumno(M,X):-alumno(N,A,B,X,C),write(A),write(" "),write(B),write(" "),write(X),
    write(" "),write(C),nl,M is (N+1),listar_alumno(M,X).


listar_clase_carrera(M,C):-clase(X,C,N,CO),write(C),write(" "),write(N),write(" "),
    write(CO),write(" "),nl,M is(X+1),listar_clase_carrera(M,C).


aprobo(Cuenta,CodigoClase):- alumno(N,Nombre,Cuenta,Carrera,Sexo),clase(Num,Carrera,NombreClase,CodigoClase),
    clasecurs(R,Cuenta,CodigoClase,Nota), Nota>=65, write(Nombre),write(" "), write(NombreClase),write(" "),
    write(Nota),write(" ")  ,write("Aprobado").

aprobo(Cuenta,CodigoClase):- alumno(N,Nombre,Cuenta,Carrera,Sexo),clase(Num,Carrera,NombreClase,CodigoClase),
    clasecurs(R,Cuenta,CodigoClase,Nota), Nota<65, write(Nombre),write(" "), write(NombreClase),write(" "),
    write(Nota),write(" ")  ,write("Reprobado").

promedio_alumno(R,PROM,Cuenta):-clasecurs(R,Cuenta,CodigoClase,Nota),Sig is R+1,
    notafinal(N,Sig,Cuenta) , PROM is ((Nota+N)/Sig).


notafinal(N,R,Cuenta):- clasecurs(R,Cuenta,CodigoClase,Nota), N is Nota.


listar_clase_promedio(CodigoClase):-clasecurs(R,Cuenta,CodigoClase,Nota),
    clase(Num,Carrera,NombreClase,CodigoClase),
    alumno(N,Nombre,Cuenta,Carrera,Sexo),
    write(Nombre),write(" "),write(NombreClase),write(" "),write(Nota).


listar_clase_prom(CodigoClase):-clasecurs(R,Cuenta,CodigoClase,Nota),
    clase(Num,Carrera,NombreClase,CodigoClase),
    alumno(N,Nombre,Cuenta,Carrera,Sexo),aprobo(Cuenta,CodigoClase).


listar_clasecurs(SIG,Cuenta):- alumno(N,Nombre,Cuenta,Carrera,Sexo),clase(Num,Carrera,NombreClase,CodigoClase),
    clasecurs(R,Cuenta,CodigoClase,Nota),write(Nombre),write(" "), write(NombreClase),write(" "),
    write(Nota),nl,SIG is R+1,listar_clasecurs(SIG,Cuenta).


agregar_alumno(N,A,B,X,C):-ALUM=alumno(N,A,B,X,C),assert(ALUM).


agregar_clasecurs(N,Cuenta,CodigoClase,Nota):-Clasecurs=clasecurs(N,Cuenta,CodigoClase,Nota),assert(Clasecurs).


eliminar_alumno(N,A,B,X,C):-ALUM=alumno(N,A,B,X,C),retract(ALUM).
























