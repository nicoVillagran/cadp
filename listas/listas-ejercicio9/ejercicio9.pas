{ 
  Utilizando el programa del ejercicio 1, realizar los siguientes módulos:
    a. EstáOrdenada: recibe la lista como parámetro y retorna true si la misma se encuentra ordenada, o
    false en caso contrario.✅
    b. Eliminar: recibe como parámetros la lista y un valor entero, y elimina dicho valor de la lista (si
    existe). Nota: la lista podría no estar ordenada. ✅
    c. Sublista: recibe como parámetros la lista L y dos valores enteros A y B, y retorna una nueva lista
    con todos los elementos de la lista L mayores que A y menores que B. ✅
    d. Modifique el módulo Sublista del inciso anterior, suponiendo que la lista L se encuentra ordenada
    de manera ascendente. ✅
    e. Modifique el módulo Sublista del inciso anterior, suponiendo que la lista L se encuentra ordenada
    de manera descendente. ✅
}
program ejercicio9;
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

function estaOrdenada(pri: lista): boolean; // esta funcion asume una lista ordenada de manera ascendente
  var
    aux : lista;
    res: boolean;
  begin
    res := true; {asumimos que la lista esta ordenada}
    aux := pri;
    while (aux <> nil) and (res) do begin
      if (aux^.num > aux^.sig^.num) then begin
        res := false;
      end;
      aux := aux^.sig;
    end;

    estaOrdenada := res;
  end;
procedure eliminar(var pri: lista; valor: integer);
  var
    aux, ant: lista;
  begin
    aux := pri;
    while (aux <> nil) and (aux^.num <> valor) do begin
      ant := aux;
      aux := aux^.sig;
    end;
    if (aux <> nil) then begin {encontre el valor}
      if (aux = pri) then begin {el valor a eliminar es el primero}
        pri := aux^.sig;
      end else begin
        ant^.sig := aux^.sig;
      end;
      dispose(aux);
    end;
  end;
procedure eliminarOrdenado(var pri: lista; valor: integer);
  var
    aux, ant: lista;
  begin
    aux := pri;
    while (aux <> nil) and (aux^.num < valor) do begin
      ant := aux;
      aux := aux^.sig;
    end;
    if (aux <> nil) and (aux^.num = valor) then begin {encontre el valor}
      if (aux = pri) then begin {el valor a eliminar es el primero}
        pri := aux^.sig;
      end else begin
        ant^.sig := aux^.sig;
      end;
      dispose(aux);
    end;
  end;
procedure insertarOrdenado(var pri: lista; num: integer); 
  var
    act, ant, nuevo: lista;
  begin
    new(nuevo);
    nuevo^.num := num;
    nuevo^.sig := nil;
    

    if pri = nil then pri := nuevo
    else begin
      act:=pri;
      ant:=pri;

      while (act <> nil) and (act^.num < num) do
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
function sublista(pri: lista; A, B: integer): lista;
  var
    res, aux: lista;
  begin
    res := nil;
    aux := pri;
    while (aux <> nil) do begin
      if (aux^.num > A) and (aux^.num < B) then begin
        insertarOrdenado(res, aux^.num);
      end;
      aux := aux^.sig;
    end;
    sublista := res;
  end;
function sublistaOrdenada(pri: lista; A, B: integer): lista;
  var
    res, aux: lista;
  begin
    res := nil;
    aux := pri;
    while (aux <> nil) and (aux^.num < B) do begin
      if (aux^.num > A) then begin
        insertarOrdenado(res, aux^.num);
      end;
      aux := aux^.sig;
    end;
    sublistaOrdenada := res;
  end;
function sublistaOrdenadaDesc(pri: lista; A, B: integer): lista;
  var
    res, aux: lista;
  begin
    res := nil;
    aux := pri;
    while (aux <> nil) and (aux^.num > A) do begin
      if (aux^.num < B) then begin
        insertarOrdenado(res, aux^.num);
      end;
      aux := aux^.sig;
    end;
    sublistaOrdenadaDesc := res;
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
end.