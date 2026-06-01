{
  Utilizando el programa del ejercicio 1, modificar el módulo armarNodo para que los elementos de la
  lista queden ordenados de manera ascendente (menor a mayor) (insertar ordenado). ✅

  10, 21, 5, 8, 3, 12, 0
}

program ejercicio8;
type
  lista = ^nodo;
  nodo = record
    num : integer;
    sig : lista;
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
    insertarOrdenado(pri, valor);
    writeln('Ingrese un numero:');
    read(valor);
  end;
  { imprimir lista }
  imprimirLista(pri);
end.s