{
  La plataforma de música Spotify desea procesar información de sus artistas.
  Para ello, dispone de una estructura de datos con información de los artistas. 
  De cada artista se conoce: nombre, genero musical (1: Funk, 2: Pop, 3: Rock, 4: Folklore, 5: Cumbia, 
  6:Cuarteto, 7: Tango, 8: Electrónica), cantidad de reproducciones de todas sus canciones, y si su perfil se encuentra verificado o no.

  Se pide realizar un programa que:

  a. Informe los dos tipos de géneros musicales que poseen mas artistas con perfil verificado.
  b. Informe el porcentaje de artistas Pop en los cuales la suma de los dígitos pares de su cantidad
    de reproducciones es igual que la suma de los dígitos impares.
  c. Genere una nueva estructura que almacene los artistas con perfil verificado con menos de 1 millón de reproducciones.

  Nota: la estructura que se dispone se debe recorrer una vez.


  ----------- desglose general --------------
    Se dispone (no crear, solo usar):
    arrGeneros = array[1..8] of str = ('Funk', 'Pop', 'Rock', 'Folklore', 'Cumbia', 'Cuarteto', 'Tango', 'Electrónica').
    artistaInfo (
      - nombre: str.
      - genero: (1..8).
      - reproducciones: int.
      - verificado: boolean.
    )
    artistas = // lista de "artistaInfo".

      ----------- declaraciones en codigo --------------
    
      Ya se "dispone" de esta estructura, por lo que solo se debe escribir
      type 
      artista = // estructura registro
      infoArtistas = // lista de artistas.
      
      var
      artistas: infoArtistas.

  -------------
  generales: contador totalArtistas.

  Acciones que debe realizar el programa:
  A) responsabilidad "encontrar2Maximos" (
      - 2 géneros (*2) 
        - verificado? (*1)
          - mas artistas (*1)
      - Informe  
    )
    Modulo *1: crear un array 8 posiciones un contador como elemento (si verificado = true aumentar contador del genero correspondiente).
    
    Modulo *2: encuentra 2 maximos y devuelve los nombres o indices. 

    *1) si (verificado) entonces contadorGenero[genero] +1.

    *2) datos:
        - generos: arrGeneros. (param)
        - max1, max2: int.
        - indiceMax1, indiceMax2: int. (param)
        - i: int (para recorrer el array de contadores).

        condiciones:
        para i = 1 hasta 8 hacer
          - si generos[i] > max1 entonces
              max2 = max1
              indiceMax2 = indiceMax1
              max1 = generos[i]
              indiceMax1 = i
          - sino si generos[i] > max2 entonces
              max2 = generos[i]
              indiceMax2 = i

  B) responsabilidad "calcularPorcentaje" (
      - artistas Pop ? (*2)
        - suma dígitos pares (reproducciones) (*1)
        - suma dígitos impares (reproducciones) (*1)
      - son guales? (*2)
      - Informe porcentaje (*3)
    )
    *1) datos:
        - num: int (param)
        - pares, impares: int (param)
        - dig: int (var)

        condiciones:
        mientras num > 0 hacer
          dig = num mod 10
          si dig mod 2 = 0 entonces
            pares = pares + dig
          sino
            impares = impares + dig
          num = num div 10
        fin mientras

    *2) si (artista genero = Pop) entonces
          // calcular suma dígitos pares e impares. llamar modulo *1
          si (pares = impares) entonces contador +1
    
    *3) porcentaje = (contador * 100) / totalArtistas.

  C) responsabilidad "generarListaVerificados" (
      
      - perfil verificado? (*2)
      - menos de 1 millón (reproducciones)? (*2)
        - almacene artistas (*1)
        - Genere una estructura (*1)
      
    )
    *1) // modulo: insertar ordenado en una lista.


    *2) datos:
        - pri: nodo. (param)
        - encontrado: boolean (var)
        - aux: nodo (var)

        incializacion:
        encontrado = false
        aux = pri

        condiciones:
        mientras (aux <> nil) y (not encontrado) hacer
          si (aux.artista.verificado = true) y (aux.artista.reproducciones < 1000000) entonces
            encontrado = true
          sino
            aux = aux.sig
        fin mientras

        si (encontrado) entonces
          // agregar a la lista de verificados. llamar modulo *1
}

program Spotify;
const dimF = 8;
type
  str = string[20];
  subrangoGenero = 1..dimF;
  arrGeneros = array[subrangoGenero] of str;
  artistaInfo = record
    nombre: str;
    genero: subrangoGenero;
    reproducciones: integer;
    verificado: boolean;
  end;
  listaArtistas = ^nodo;
  nodo = record
    artista: artistaInfo;
    sig: listaArtistas;
  end;

// modulos
procedure contadorGenero(var arr: arrGeneros; genero: subrangoGenero);
  begin
    arr[genero] := arr[genero] + 1;
  end;

procedure encontrar2Maximos(arr: arrGeneros; var indiceMax1, indiceMax2: subrangoGenero);
  var
    i, max1, max2: integer;
  begin
    max1 := 0;
    max2 := 0;
    indiceMax1 := 0;
    indiceMax2 := 0;

    for i := 1 to dimF do
    begin
      if arr[i] > max1 then
      begin
        max2 := max1;
        indiceMax2 := indiceMax1;
        max1 := arr[i];
        indiceMax1 := i;
      end
      else if arr[i] > max2 then
      begin
        max2 := arr[i];
        indiceMax2 := i;
      end;
    end;
  end;
procedure sumaDigitos (num: integer; var pares, impares: integer);
  var
    dig: integer;
  begin
    pares := 0;
    impares := 0;

    while num > 0 do
    begin
      dig := num mod 10;
      if dig mod 2 = 0 then
        pares := pares + dig
      else
        impares := impares + dig;
      num := num div 10;
    end;
  end;
procedure cantArtistasPop(genero, reproducciones: integer; var contador: integer);
  var
    pares, impares: integer;
  begin
    if genero = 2 then // Pop
    begin
      sumaDigitos(reproducciones, pares, impares);
      if pares = impares then
        contador := contador + 1;
    end;
  end;
function calcularPorcentaje(contador, total: integer): real;
  begin
    if total > 0 then
      calcularPorcentaje := (contador * 100) / total
    else
      calcularPorcentaje := 0;
  end;
procedure insertarOrdenado(var pri: listaArtistas; art: artistaInfo); 
  var
    act, ant, nuevo: listaArtistas;
  begin
    new(nuevo);
    nuevo^.artista := art;
    nuevo^.sig := nil;
    

    if pri = nil then pri := nuevo
    else begin
      act:=pri;
      ant:=pri;

      while (act <> nil) and (act^.artista.reproducciones < art.reproducciones) do
        begin
          ant := act;
          act := act^.sig;
        end;

      if act = pri then begin
        nuevo^.sig := pri;
        pri := nuevo;
      end
      else begin
        nuevo^.sig := act;
        ant^.sig := nuevo;
      end;
    end;
  end;
procedure generarListaVerificados(art: artistaInfo; var verificados: listaArtistas);
  begin
    if (art.verificado) and (art.reproducciones < 1000000) then
      insertarOrdenado(verificados, art);
  end;
procedure recorrerLista(pri: listaArtistas; arr: arrGeneros; var contadorPop, totalArtistas: integer; var verificados: listaArtistas);
  var
    aux : listaArtistas;
  begin
    aux := pri;
    while (aux <> nil) do begin
      
      aux := aux^.sig;
    end;
  end;