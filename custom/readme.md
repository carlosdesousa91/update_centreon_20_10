# Procedimento - Pagina de login:
## 01 - logo:

A logo externa deve ser substituída no caminho: /usr/share/centreon/www/img/centreon.png

## 02 - Botão login:

Alterar cor do botão login

diretorio: /usr/share/centreon/www/Themes/Centreon-2/
arquivo: login.css
Procurar por: .bt_info
Alterar de: background: #00bfb3 !important;
Para: background: #003399 !important;

Procurar por: input[type="submit"].bt_info:hover
Alterar de: background-color: #00a499 !important;
Para: background: #003399 !important;

## Procedimento - Front-End:
### 01 - logo-Icone:

no arquivo /usr/share/centreon/www/static/vendor.e7a65e18.js localizar as imagens e substituir pela abaixo:

"img/centreon.png"

"/centreon/img/centreon_mini.png"

Obs: as imagens originais são no formato base64, deve localizar toda a string e troca, ex: data:image/png;base64,iVBORw0KGg...

incluir também o estilo abaixo para no fim do arquivo /usr/share/centreon/www/static/vendor.e7f5e355.chunk.css:

```

.logo-mini__1zeEQ img{
height:40px;
width:40px;
left: 3px;
position: absolute;
top: 5px;
}

```

### 02 - barras:

#### no arquivo /usr/share/centreon/www/static/main.63dc8264.chunk.css localizar a cor do header e do footer e substituir.

de: .header__3vGR5{background-color:#232f39;  
#### para : .header__3vGR5{background-color:#003399;

de: .footer__Vtfi7{padding:0 100px 0 20px;box-sizing:border-box;background-color:#232f39;
#### para : .footer__Vtfi7{padding:0 100px 0 20px;box-sizing:border-box;background-color:#003399;


#### no arquivo /usr/share/centreon/www/static/vendor.e7f5e355.chunk.css  , modificar conforme abaixo:

de: .submenu-top__2firh{position:relative;padding:6px 20px 7px 20px;flex-wrap:wrap;align-items:center;background-color:#232f39}
#### para: .submenu-top__2firh{position:relative;padding:6px 20px 7px 20px;flex-wrap:wrap;align-items:center;background-color:#003399}


### 03 - Hard only:

no arquivo /usr/share/centreon/www/include/eventLogs/template/viewLog.ihtml procurar o input com o id="ohId" e incluir o atributo checked="checked", com isso o checkbox já virá marcado.


# Procedimento - Incluir ícones WeatherMap/viaIpê/splunk no Centreon (versão:20.10.0)
## 01 - Menu:

### no arquivo /usr/share/centreon/www/index.html incluir o style dentro da "head" do arquivo html:

``` 

<style>
#topologia{
position: absolute;
z-index: 1;
width: 190px;
font-size: .6875rem;
color: #fff;
font-family: Roboto Light;
text-transform: lowercase;
right: 650px;
height: 40px;
margin-top: 10px;
}
</style> 

```


### e a div dentro do "body" do arquivo html:


```
<div id="topologia">
<tr>
<!--<span>Topologia de rede</span>-->
<td>
<a title="Splunk" onclick="iframe('https://operacao.rnp.br:8080')">
<img src="./img/splunkIcon.png" style="display:inline-block; width:25px; "></a>
</td>
<td>
<a title="Rede Ip&ecirc;" onclick="iframe('https://trafego.rnp.br/cacti/plugins/weathermap/weathermap-cacti-plugin-public.php?action=viewmap&amp;id=ab66cf5b1230229dda5f')">
<img src="./img/redeIpe4.png" style="display:inline-block; width:30px; padding-left: 6px; "></a>
</td>
<td>
<a title="Via Ip&ecirc;" onclick="iframe('https://viaipe.rnp.br/?embedded=true')">
<img src="./img/faviconViaIpe.png" style="display:inline-block; width:22px; padding-left: 6px; border-right: 1px solid #e7e7e8; padding-right: 16px;"></a>
</td>
</tr>
</div> 
```



### e o script dentro do "head" do arquivo html:

```
<script>
        function iframe(url){
                var jss3 = document.getElementsByClassName('jss3')[0];
                var div = jss3.childNodes[0];
                div.style.display = "block";
                div.innerHTML = '<iframe id="main-content" title="Main Content" frameborder="0" scrolling="yes" class="" src="'+url+'" style="width: 100%; height: 100%;"></iframe>';
                document.getElementById("main-content").src = url;
        };
</script>
```
