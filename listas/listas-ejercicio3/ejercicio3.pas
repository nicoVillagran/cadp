{
  Utilizando el programa del ejercicio 1, realizar los siguientes cambios:
    a. Modificar el módulo armarNodo para que los elementos se guarden en la lista en el orden en que
    fueron ingresados (agregar atrás). ✅

    b. Modificar el módulo armarNodo para que los elementos se guarden en la lista en el orden en que
    fueron ingresados, manteniendo un puntero al último ingresado. ✅
}

program ejercicio3;
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

var
  pri, ult : lista;
  valor : integer;
begin
  pri := nil;
  ult := nil;
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
  // { incrementar lista }
  // writeln('Ingrese un valor para incrementar los elementos de la lista:');
  // read(valor);
  // incrementarLista(pri, valor);
  // { imprimir lista actualizada }
  // imprimirLista(pri);
end.