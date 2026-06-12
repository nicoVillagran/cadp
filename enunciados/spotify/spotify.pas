{
  La plataforma de música Spotify desea procesar información de sus artistas.
  Para ello, dispone de una estructura de datos con información de los artistas. 
  De cada artista se conoce: nombre, genero musical (1: Funk, 2: Pop, 3: Rock, 4: Folklore, 5: Cumbia, 6:Cuarteto, 
  7: Tango, 8: Electrónica), cantidad de reproducciones de todas sus canciones, y si su perfil se encuentra verificado o no.

  Se pide realizar un programa que:

    1. Informe los dos tipos de géneros musicales que poseen mas artistas con perfil verificado.
    2. Informe el porcentaje de artistas Pop en los cuales la suma de los dígitos pares de si 
        cantidad de reproducciones es igual que la suma de los dígitos impares.
    3. Genere una nueva estructura que almacene los artistas con perfil verificado con menos de 1 millón de reproducciones.
}

program spotify;
const dimFGeneros = 8;
// tipos
type
  generos = array [1..dimFGeneros] of string;
  generosMax = array [1..dimFGeneros] of integer;
  artista = record
    nombre: string;
    genero: 1..dimFGeneros;
    resproducciones: int64;
    verificado: boolean;
  end;

  lista = ^nodo;
  nodo = record
    elem: artista;
    sig: lista;
  end;

// modulos
// accion A
procedure inicializarArrayMax(var v: generosMax);
  var i: integer;
  begin
    for i:=0 to dimFGeneros do v[i] := 0;
  end;
procedure agregarVector (var v: generosMax; i: integer);
  begin
    v[i] := v[i] + 1;
  end;
procedure encontrar2Max (v: generosMax; var max1, max2: integer);
  var i: integer;
  begin
    max1:= 1;
    max2:= 1;

    for i:= 2 to dimFGeneros do begin
      if (v[i] >= v[max1]) then begin
        max2 := max1;
        max1 := i;
      end
      else begin
        if (v[i] >= v[max2]) then max2 := i;
      end;
    end;
  end;
// accion B
function calPorcentaje(total, cant: integer): real;
  begin
    calPorcentaje:=(cant * 100) / total;
  end;
function digParImpar (num: integer): boolean;
  var
    dig, sumPar, sumImpar: integer;
  begin
    dig:=0;
    sumPar:=0;
    sumImpar:=0;

    while num <> 0 do begin
      dig := num MOD 10;

      if ((dig MOD 2) = 0) then sumPar := sumPar + dig
      else sumImpar := sumImpar + dig;

      num := num DIV 10;
    end;

    digParImpar:= (sumPar = sumImpar);
  end;
// accion C
procedure agregarNodo (var pri: lista; dato: artista);
  var nuevo: lista;
  begin
    new(nuevo);
    nuevo^.elem := dato;
    nuevo^.sig := pri;
    pri := nuevo;
  end;
// general
procedure recorrerLista (L: lista; var nuevaL: lista; vGeneros: generos);
  var
    max1, max2: integer;
    cantPop, cantRepro: integer;
    porcentaje: real;
    res: Boolean;
    v: generosMax;
    aux: lista;
  begin
    cantPop:=0;
    cantRepro:=0;
    
    inicializarArrayMax(v);

    nuevaL:=nil;

    while L <> nil do begin
      if(L^.elem.verificado) then agregarVector(v, L^.elem.genero);

      if(L^.elem.genero = 2) then begin
        cantPop := cantPop + 1;
        res:=digParImpar(L^.elem.resproducciones);

        if(res)then cantRepro := cantRepro + 1;
      end;

      if(L^.elem.verificado) and (L^.elem.resproducciones < 1000000) then agregarNodo(nuevaL, L^.elem);

      L:=L^.sig;
    end;

    encontrar2Max(v, max1, max2);
    WriteLn('el genero con mas artistas verificados: ', max1);
    WriteLn('2do genero con mas artistas verificados: ', max2);

    porcentaje:=calPorcentaje(cantPop, cantRepro);
    writeln('Hay ',  cantPop, ', de los cuales, el ', porcentaje:0:2, '% cumple las condiciones.');

    writeln('artistas verificados con menos de 1millon de reproducciones:');
    aux:=nuevaL;
    
    if(aux = nil) then WriteLn('Lista vacia')
    else begin
      while aux <> nil do begin
        writeln(aux^.elem.nombre);
        aux := aux^.sig;
      end;
    end;
  end;
// agregados para que corra el programa
procedure cargarVGeneros(var v: generos);
  begin
    v[1]:='Funk';
    v[2]:='Pop';
    v[3]:='Rock';
    v[4]:='Folklore';
    v[5]:='Cumbia';
    v[6]:='Cuarteto';
    v[7]:='Tango';
    v[8]:='Electrónica';
  end;
procedure leerUnRegistro(var r: artista);
  var res: string;
  begin
    writeln('nombre: ');
    readln(r.nombre);
    if (r.nombre <> 'no') then begin
      writeln('genero: ');
      readln(r.genero);
      writeln('reproducciones: ');
      readln(r.resproducciones);
      writeln('verificado (si/no): ');
      readln(res);
      r.verificado := (res = 'si');
    end;
  end;
procedure cargarLista(var L: lista);
  var
    r: artista;
    nuevo: lista;
  begin
    L:=nil;

    WriteLn('ingres info del artista: ');
    leerUnRegistro(r);

    while (r.nombre <> 'no') do begin
      New(nuevo);
      nuevo^.elem:= r;
      nuevo^.sig:=L;
      L:= nuevo;

      leerUnRegistro(r);
    end;
  end;

// programa principal
Var
  L, nuevaL: lista; // "L" se dispone
  vGeneros: generos; // se dispone
Begin
   cargarVGeneros(vGeneros); // se dispone
   cargarLista(L); // se dispone

  recorrerLista(L, nuevaL, vGeneros);
End.

{
  datos de prueba:
  1. art1, 3,  500.000,  si

  2. art2, 3, 2.500.000,  si

  3. art3, 2,    1357,  si 

  4. art4, 2,    2433,  no

  5. art5, 8, 3.000.000,  si

  6. art6, 5,  150.000,  si
  
}