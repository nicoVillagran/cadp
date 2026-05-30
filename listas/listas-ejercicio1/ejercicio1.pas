{
  a. Indicar qué hace el programa. ✅
     El programa genera una lista enlazada de números enteros, donde cada nodo contiene un número y un puntero al siguiente nodo.
     El programa solicita al usuario que ingrese números enteros y los agrega a la lista hasta que el usuario ingrese el número 0,
     lo que indica el final de la entrada.

  b. Indicar cómo queda conformada la lista si se lee la siguiente secuencia de números: 10 21 13 48 0. ✅
      La lista quedaría conformada de la siguiente manera:
      - El primer nodo contiene el número 48 y apunta al siguiente nodo.
      - El segundo nodo contiene el número 13 y apunta al siguiente nodo.
      - El tercer nodo contiene el número 21 y apunta al siguiente nodo.
      - El cuarto nodo contiene el número 10 y apunta a nil (indica el final de la lista).
  c. Implementar un módulo que imprima los números enteros guardados en la lista generada. ✅
  d. Implementar un módulo que reciba la lista y un valor, e incremente con ese valor cada dato de la
  lista.
}

program ejercicio1;
type
  lista = ^nodo;
  nodo = record
    num : integer;
    sig : lista;
  end;
procedure armarNodo(var L: lista; {el primero} v: integer {numero}); {  agrega un nodo al principio de la lista }
  var
    aux : lista; // actua como un dispose para liberar memoria
  begin
    new(aux); {direccion}
    aux^.num := v;
    aux^.sig := L; {nil}
    L := aux;
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
  pri : lista;
  valor : integer;
begin
  pri := nil;
  writeln('Ingrese un numero:');
  read(valor);
  while (valor <> 0) do begin
    armarNodo(pri, valor);
    writeln('Ingrese un numero:');
    read(valor);
  end;
  { imprimir lista }
  imprimirLista(pri);
  { incrementar lista }
  writeln('Ingrese un valor para incrementar los elementos de la lista:');
  read(valor);
  incrementarLista(pri, valor);
  { imprimir lista actualizada }
  imprimirLista(pri);
end.