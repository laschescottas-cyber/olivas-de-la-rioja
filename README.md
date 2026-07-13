# Olivas de La Rioja 🫒

Catálogo web de productos regionales de La Rioja.

## Funcionalidades

- Catálogo organizado por categorías.
- Carrito de compras.
- Cálculo automático del total.
- Envío del pedido por WhatsApp.
- Compra normal y acceso para revendedores en el mismo link.
- Variantes por producto con desplegable de presentación/precio.
- Selector de cantidad para todos los productos.
- Acceso directo a Instagram.
- Diseño adaptable a celulares y computadoras.

## Cómo cargar variantes

El catálogo lee `productos.csv`.

Si varias filas tienen la misma `Categoria` y el mismo `Producto`, el sitio las muestra como una sola tarjeta con un desplegable.

Excepción actual: la categoría `Aceites` no se agrupa. Cada aceite queda como tarjeta separada porque cada envase tiene su propia foto/presentación visual.

Ejemplo:

```csv
Categoria,Producto,Presentacion,Precio,Imagen
Dulces y Varios,Dulce de membrillo (Pan),650grs,$7.000,img/dulce_membrillo_650.jpg
Dulces y Varios,Dulce de membrillo (Pan),270grs,$3.500,img/dulce_membrillo_650.jpg
```

En ese caso se ve una sola tarjeta "Dulce de membrillo (Pan)" y la persona elige 650grs o 270grs.

Si querés usar una sola foto para todas las variantes, poné la misma imagen en esas filas.

También se puede agregar una columna opcional llamada `Grupo` si querés forzar que varias filas se agrupen bajo otro nombre.

## Ver el catálogo

👉 [Abrir Olivas de La Rioja](https://laschescottas-cyber.github.io/olivas-de-la-rioja/)

## Tecnologías utilizadas

- HTML
- CSS
- JavaScript

© 2026 Olivas de La Rioja. Todos los derechos reservados.
