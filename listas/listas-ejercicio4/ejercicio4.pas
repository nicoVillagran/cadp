{
  Utilizando el programa del ejercicio 1, realizar los siguientes módulos:
    a. Máximo: recibe la lista como parámetro y retorna el elemento de valor máximo. ✅
    b. Mínimo: recibe la lista como parámetro y retorna el elemento de valor mínimo. ✅
    c. Múltiplos: recibe como parámetros la lista L y un valor entero A, y retorna la cantidad de
    elementos de la lista que son múltiplos de A. ✅

    10, 21(m), 5, 8, 3(m), 12(m), 0
}

program ejercicio4;
type
  lista = ^nodo;
  nodo = record
    num : integer;
    sig : lista;
  end;
procedure agregarAtras(var L: lista; {primero} v: integer {numero}); {  recorrer y agregar un nodo al al final de la lista }
  var
    aux : lista; // actua como un dispose para liberar memoria
    nuevo : lista; // nuevo nodo a agregar
  begin
    new(nuevo); {direccion}
    nuevo^.num := v;
    nuevo^.sig := nil; {nil}

    if L = nil then
      L := nuevo
    else begin
      aux := L;
      while aux^.sig <> nil do
        aux := aux^.sig;
      aux^.sig := nuevo;
    end;
  end;
procedure agregarAlFinal(var L, ultimo: lista; {último nodo} v: integer {numero}); {  agrega un nodo al final de la lista }
  var
    //aux : lista; // actua como un dispose para liberar memoria // no usaremos este auxiliar porque no es necesario para agregar al final
    nuevo : lista; // nuevo nodo a agregar
  begin
    new(nuevo); {direccion}
    nuevo^.num := v;
    nuevo^.sig := nil; {nil}
    if (L = nil) then
      L := nuevo
    else
      ultimo^.sig := nuevo;
    ultimo := nuevo; // cada vez que se agrega un nuevo nodo, guardamos su dirección en el puntero ultimo. // evitamos recorrer la lista hasta el final.
  end;

procedure imprimirLista(pri: lista);
  var
    aux : lista;
  begin
    aux := pri;
    while (aux <> nil) do begin
      writeln(aux^.num);
      aux := aux^.sig;
    end;
  end;
procedure incrementarLista(var pri: lista; valor: integer);
  var
    aux : lista;
  begin
    aux := pri;
    while (aux <> nil) do begin
      aux^.num := aux^.num + valor;
      aux := aux^.sig;
    end;
  end;
  // los comentarios con "(*1)" indican los cambios realizados para que el módulo "maximo" retorne un nodo en vez de un numero, esto es para que el módulo "maximo" pueda ser reutilizado para el módulo "minimo" sin necesidad de hacer cambios adicionales.
function maximo(pri: lista): lista; //(*1) retornar un elemento "lista"
  var
    aux : lista;
    max : lista; //(*1) lista
  begin
    if pri = nil then
      max := nil // o algún valor que indique que la lista está vacía // (*1) cambiar "-1" por "nil"
    else begin
      max := pri; {(*1)solo "pri"}; // inicializamos max con el primer nodo de la lista
      aux := pri^.sig;
      while (aux <> nil) do begin
        if aux^.num > max^.num then
          max := aux; //(*1) dar a max el valor de "aux" solamente //(*1) esto hace que max apunte al nodo que contiene el valor mas grande.
        aux := aux^.sig;
      end;
    end;
    maximo := max; // (*1)NO cambiar. Con los cambios anteriores aca en vez de retornar un numero retornamos un nodo, cuando querramos imprimir el valor solo accedemos con "max^.num".
  end;
function minimo(pri: lista): lista; //(*1) retornar un elemento "lista"
  var
    aux : lista;
    min : lista; //(*1) lista
  begin
    if pri = nil then
      min := nil // o algún valor que indique que la lista está vacía // (*1) cambiar "-1" por "nil"
    else begin
      min := pri; {(*1)solo "pri"}; // inicializamos min con el primer nodo de la lista
      aux := pri^.sig;
      while (aux <> nil) do begin
        if aux^.num < min^.num then
          min := aux; //(*1) dar a min el valor de "aux" solamente //(*1) esto hace que min apunte al nodo que contiene el valor mas pequeño.
        aux := aux^.sig;
      end;
    end;
    minimo := min; // (*1)NO cambiar. Con los cambios anteriores aca en vez de retornar un numero retornamos un nodo, cuando querramos imprimir el valor solo accedemos con "min^.num".
  end;
function multiplos(pri: lista; valor: integer): integer;
  var
    aux : lista;
    contador : integer;
  begin
    contador := 0;
    aux := pri;
    while (aux <> nil) do begin
      if (aux^.num mod valor = 0) then
        contador := contador + 1;
      aux := aux^.sig;
    end;
    multiplos := contador;
  end;


var
  pri : lista;
  // ult : lista;
  valor : integer;
begin
  pri := nil;
  // ult := nil;
  writeln('Ingrese un numero:');
  read(valor);
  while (valor <> 0) do begin
    //agregarAlFinal(pri, ult, valor); // agregar al final manteniendo un puntero al último nodo
    agregarAtras(pri, valor); // agregar al final recorriendo la lista cada vez
    writeln('Ingrese un numero:');
    read(valor);
  end;
  { imprimir lista }
  imprimirLista(pri);
  // // { imprimir el numero maximo y minimo }
  // writeln('El numero maximo es: ', maximo(pri)^.num);
  // writeln('El numero minimo es: ', minimo(pri)^.num);
  {imprimir la cantidad de multiplos de un numero y preguntar si terminar o encontrar otrar la cantidad de multiplos de otro numero}
  writeln('Ingrese un numero para encontrar la cantidad de multiplos en la lista:');
  read(valor);
  while (valor <> 0) do begin
    writeln('La cantidad de multiplos de ', valor, ' en la lista es: ', multiplos(pri, valor));
    writeln('Ingrese otro numero para encontrar la cantidad de multiplos en la lista o ingrese 0 para terminar:');
    read(valor);
  end;
end.