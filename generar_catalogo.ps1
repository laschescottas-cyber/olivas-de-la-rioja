$configCategorias = @{
    "Aceites" = @{ desc = "La esencia de nuestra tierra. Aceites de oliva prensados con la tradici&oacute;n y el sol de La Rioja."; img = "img/aceites.jpg" }
    "Aceitunas" = @{ desc = "Nuestra Variedad Arauco es, por definici&oacute;n, el emblema de la olivicultura riojana."; img = "img/aceitunas.jpg" }
    "Frutos Secos" = @{ desc = "Selecci&oacute;n de frutos secos de alta calidad, cosechados en el coraz&oacute;n de nuestra provincia."; img = "img/frutos_secos.jpg" }
    "Dulces y Varios" = @{ desc = "Sabores regionales artesanales que evocan los mejores recuerdos de nuestra cultura riojana."; img = "img/dulces.jpg" }
    "Vinos" = @{ desc = "Bodegas de La Rioja. Vinos artesanales seleccionados."; img = "img/vinos.jpg" }
}

$productos = Import-Csv "productos.csv"

$html = @"
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Olivas de La Rioja</title>
    <style>
        :root { --oro: #C5A059; --oscuro: #1A1A1A; --fondo-card: #222; }
        body { background: var(--oscuro); color: #F5F5DC; font-family: 'Georgia', serif; margin: 0; padding: 0; }

        /* BANNER */
        header { height: 400px; background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.7)), url('img/banner.jpg'); background-size: cover; background-position: center; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; color: #fff; border-bottom: 5px solid var(--oro); }
        header h1 { color: var(--oro); font-size: 4.5em; text-transform: uppercase; letter-spacing: 3px; margin: 0; text-shadow: 2px 2px 10px rgba(0,0,0,0.8); }

        /* TEXTO DE PRESENTACION DEBAJO DEL TITULO */
        .presentacion-marca { max-width: 780px; margin: 18px 25px 0; color: #F5F5DC; font-size: 1.08em; line-height: 1.55; text-shadow: 1px 2px 5px rgba(0,0,0,0.95); }
        .presentacion-marca strong { display: block; color: var(--oro); font-size: 1.35em; margin-bottom: 5px; }

        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 40px; padding: 40px; max-width: 1200px; margin: auto; }
        .card { border: 1px solid var(--oro); background: var(--fondo-card); padding: 20px; text-align: center; border-radius: 4px; transition: 0.3s; }
        .card:hover { transform: translateY(-5px); border-color: #F5F5DC; }
        .card img { width: 100%; height: 280px; object-fit: cover; border: 1px solid var(--oro); margin-bottom: 20px; }

        /* CARRITO MAS COMPACTO */
        .carrito { position: fixed; top: 12px; right: 12px; background: var(--oro); color: black; padding: 11px; border-radius: 8px; width: 240px; max-height: 68vh; overflow-y: auto; z-index: 1000; box-shadow: 0 4px 15px rgba(0,0,0,0.5); box-sizing: border-box; }
        .carrito h3 { margin: 2px 0 9px; font-size: 1.05em; }
        .carrito ul { list-style: none; padding: 0; margin: 0; }
        .carrito li { display: flex; justify-content: space-between; align-items: center; gap: 7px; background: rgba(255,255,255,0.2); margin-bottom: 5px; padding: 6px 7px; border-radius: 4px; font-size: 0.78em; line-height: 1.25; }
        .carrito .nombre-item { flex: 1; min-width: 0; overflow-wrap: anywhere; }
        #total-carrito { font-weight: bold; margin-top: 8px; font-size: 0.9em; }
        .carrito > button { padding: 8px; font-size: 0.78em; margin-top: 8px; }

        /* CESTO AL LADO DEL PRODUCTO ELEGIDO */
        .btn-eliminar { flex: 0 0 26px; cursor: pointer; color: #6D1111; background: rgba(255,255,255,0.35); border: 1px solid #6D1111; border-radius: 5px; width: 26px; height: 26px; padding: 0; margin: 0; display: inline-flex; align-items: center; justify-content: center; font-size: 14px; line-height: 1; }
        .btn-eliminar:hover { background: #6D1111; color: white; }

        button { background: #2D4837; color: white; border: 1px solid #fff; padding: 10px; cursor: pointer; width: 100%; margin-top: 10px; }
        h2 { color: var(--oro); text-align: center; margin-top: 60px; }
        .desc-cat { text-align: center; color: #ccc; font-style: italic; margin-bottom: 20px; max-width: 800px; margin-left: auto; margin-right: auto; }
        footer { padding: 40px; text-align: center; border-top: 1px solid #444; background: #111; color: #ccc; }
        footer a { color: var(--oro); text-decoration: none; font-weight: bold; }

        @media (max-width: 700px) {
            header h1 { font-size: 2.35em; }
            .presentacion-marca { font-size: 0.92em; margin-left: 18px; margin-right: 18px; }
            .carrito { width: 210px; top: 8px; right: 8px; max-height: 55vh; }
        }
    </style>
</head>
<body>
    <header>
        <h1>Olivas de La Rioja</h1>
        <div class="presentacion-marca">
            <strong>El sabor de La Rioja en tu mesa</strong>
            Soy Jos&eacute; y te traigo lo mejor de mi tierra. Aceites de oliva, aceitunas, frutos secos seleccionados y dulces artesanales. Todo cosechado en el coraz&oacute;n de La Rioja, con la calidad y el cari&ntilde;o de lo hecho en casa. Sabores que te hacen acordar a lo de la abuela.
        </div>
    </header>
    <div class="carrito">
        <h3>Tu Carrito</h3>
        <ul id="lista-carrito"></ul>
        <div id="total-carrito">Total: $0</div>
        <button onclick="enviarWhatsApp()">FINALIZAR PEDIDO</button>
    </div>
    <div id="catalogo">
"@

foreach ($cat in ($productos | Select-Object -ExpandProperty Categoria -Unique)) {
    $cfg = $configCategorias[$cat]
    $html += "<h2>$cat</h2>"
    if ($cfg.desc) { $html += "<p class='desc-cat'>$($cfg.desc)</p>" }
    if ($cfg.img) { $html += "<img src='$($cfg.img)' style='width:100%; max-width:800px; display:block; margin:auto; margin-bottom: 30px; border: 1px solid #C5A059;'>" }

    $html += "<div class='grid'>"
    foreach ($p in ($productos | Where-Object { $_.Categoria -eq $cat })) {
        $foto = if ($p.Imagen) { $p.Imagen } else { "img/placeholder.jpg" }
        $html += @"
            <div class="card">
                <img src='$foto'>
                <h3>$($p.Producto)</h3>
                <p>$($p.Presentacion)</p>
                <p><strong>$($p.Precio)</strong></p>
                <button onclick="agregarAlCarrito('$($p.Producto)', '$($p.Presentacion)', '$($p.Precio)')">Agregar</button>
            </div>
"@
    }
    $html += "</div>"
}

$html += @"
    </div>
    <footer>
        <p>Realiza tu pedido con Jose v&iacute;a <a href='https://wa.me/5493804559043' target='_blank'>WhatsApp</a></p>
        <p>Seguinos en Instagram: <a href='https://www.instagram.com/olivasdelarioja' target='_blank'>@olivasdelarioja</a></p>
    </footer>
    <script>
        let carrito = [];
        let contador = 0;
        function agregarAlCarrito(prod, pres, precioTxt) {
            let precioNum = parseInt(precioTxt.replace('$', '').replace(/\./g, ''));
            carrito.push({id: contador++, nombre: prod + ' (' + pres + ')', precioTxt: precioTxt, precioNum: precioNum});
            actualizar();
        }
        function eliminar(id) {
            carrito = carrito.filter(i => i.id !== id);
            actualizar();
        }
        function actualizar() {
            let lista = document.getElementById('lista-carrito');
            lista.innerHTML = '';
            let total = 0;
            carrito.forEach(item => {
                total += item.precioNum;
                lista.innerHTML += '<li><span class="nombre-item">' + item.nombre + ' - ' + item.precioTxt +
                '</span><button class="btn-eliminar" title="Quitar producto" aria-label="Quitar producto" onclick="eliminar(' + item.id + ')">&#128465;</button></li>';
            });
            document.getElementById('total-carrito').innerText = 'Total: $' + total.toLocaleString('es-AR');
        }
        function enviarWhatsApp() {
            let msg = "Hola Jose, quiero hacer el siguiente pedido:%0A%0A" +
                      carrito.map(i => "- " + i.nombre).join("%0A") +
                      "%0A%0A*TOTAL: $" + document.getElementById('total-carrito').innerText.split('$')[1] + "*";
            window.open('https://wa.me/5493804559043?text=' + msg, '_blank');
        }
    </script>
</body>
</html>
"@

$html | Out-File "$PSScriptRoot\index.html" -Encoding utf8
Write-Host "Catálogo generado exitosamente con carrito compacto y presentación de marca" -ForegroundColor Green