{
  Realizar un programa que lea y almacene la información de productos de un supermercado. De cada
  producto se lee: código, descripción, stock actual, stock mínimo y precio. La lectura finaliza cuando se
  ingresa el código -1, que no debe procesarse. Una vez leída y almacenada toda la información, calcular e informar:
    a. Porcentaje de productos con stock actual por debajo de su stock mínimo.
    b. Descripción de aquellos productos con código compuesto por al menos tres dígitos pares.
    c. Código de los dos productos más económicos.

  producto = (
    código: int,
    descripción: str,
    stock actual: int,
    stock mínimo: int,
    precio: real
  )

  acciones:
    - leer estructura.
    - mientras (no condicion fin) leer agregarNodo.
    - comparacion "s.actual" con "s.minimo", devolver boolean. contar y sacar un porcentaje. ✅
    - analizar digitos pares (contar). del codigo. ✅
    - si (digPares) entonces guardar descripcion para mostrar mas tarde. ✅
    - encontrar los 2 mas baratos, trabajando con registros. ✅

  A) responsabilidades "Porcentaje" (
    
    - Porcentaje (del total)
    - productos (cant)
      - stock actual < stock mínimo.
          cant + 1
  ).
  B) responsabilidades "AnalizarDigitos" (
    
    - productos 
    - dígitos pares código >= 3
      - Descripción -> guardar lista (general)
  ).
  C) responsabilidades "Encontrar2Minimos" (
    
    - modulo 2 minimos (if-else), (recibe y devuelve "registros").
    - puede ejecutarse en el recorrido de la lista.
    
    - Código (general)
    - 2 productos
    - precio < precioMinimo.
  ).

}

program ejercicio5;
// tipos
type
  producto = record
    codigo: integer;
    descripcion: string;
    stockActual: integer;
    stockMinimo: integer;
    precio: real;
  end;
  lista = ^nodo;
  nodo = record
    elem: producto;
    sig: lista;
  end;

// modulos
// accion A
procedure producFaltantes (var contador: integer; stockAct, stockMin:integer);
  begin
    if stockAct < stockMin then contador:=contador + 1;
  end;
function porcentajeFaltantes (total, faltantes: integer):real;
  var res : real;
  begin
    res:= (faltantes * 100) / total;
    porcentajeFaltantes:=res;
  end;
// accion B
procedure digPares(p: producto);
  var
    num, dig, pares: integer;
  begin
    num:=p.codigo;
    dig:=0;
    pares:=0;

    while (num <> 0) and (pares < 3) do begin
      dig := num MOD 10;
      
      if((dig MOD 2) = 0) then pares := pares + 1;

      num := num DIV 10;
    end;

    if (pares >= 3) then WriteLn('Descripcion: ', p.descripcion);
  end;
// accion C
procedure encontrar2Minimos (p: producto; var min1, min2: producto);
  var
    precio, pMin1, pMin2: real;
  begin
    precio := p.precio;
    pMin1 := min1.precio;
    pMin2 := min2.precio;

    if (precio <= pMin1) then begin
      min2:=min1;
      min1:=p;
    end
    else if precio <= pMin2 then min2 := p;
  end;
// general
procedure leerProducto (var p: producto);
  begin
    WriteLn('ingrese datos del producto: ');
    writeln('codigo:');
    readln(p.codigo);
    if(p.codigo <> -1)then begin
      writeln('descripcion:');
      readln(p.descripcion);
      writeln('stock actual:');
      readln(p.stockActual);
      writeln('stock minimo:');
      readln(p.stockMinimo);
      writeln('precio:');
      readln(p.precio);
    end;
    WriteLn('---------------------')
  end;
procedure cargarLista(var pri: lista);
  var
    rProducto: producto;
    nuevo: lista;
  begin
    pri := nil;
    leerProducto(rProducto);

    while rProducto.codigo <> -1 do begin
      New(nuevo);
      nuevo^.elem := rProducto;
      nuevo^.sig := pri;

      pri := nuevo;

      leerProducto(rProducto);
    end;
  end;
procedure recorreLista (pri: lista);
  var
    min1, min2: producto;
    totalProd, faltantesProd: integer;
    porcentaje: real;
  begin
    totalProd:=0;
    faltantesProd:=0;
    
    while pri <> nil do begin
      producFaltantes(faltantesProd, pri^.elem.stockActual, pri^.elem.stockMinimo);
      digPares(pri^.elem);
      encontrar2Minimos(pri^.elem, min1, min2);

      totalProd := totalProd + 1;
      pri := pri^.sig;
    end;

    porcentaje := porcentajeFaltantes(totalProd, faltantesProd);
    
    WriteLn('el porcentaje de productos faltantes es: ', porcentaje:0:2, '%');
    WriteLn('codigo del producto mas barato: ', min1.codigo);
    WriteLn('codigo del 2do producto mas barato: ', min2.codigo);
  end;

var
  pri: lista;
begin
  cargarLista(pri);
  recorreLista(pri);
end.

{
  1.  246,   "leche entera",  10, 20, 1200.50
  2.  135, "arroz integral",  50, 10,  850.00
  3. 8024, "fideos moñitos",   5, 15,  600.00
  4.   20, "aceite girasol",  30, 30, 2500.00
  5.  246, "yogur frutilla", 100, 40, 1400.00
}