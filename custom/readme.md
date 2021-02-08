# Procedimento - Incluir ícones WeatherMap/viaIpê/splunk no Centreon (versão:20.10.0)
## 01 - Menu:

### no arquivo /usr/share/centreon/www/index.html incluir o style dentro da "head" do arquivo html:


``` <style>
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
</style> ```


### e a div dentro do "body" do arquivo html:


```<div id="topologia">
<tr>
<!--<span>Topologia de rede</span>-->
<td>
<a title="Splunk" onclick="iframe('https://operacao.rnp.br:8080')">
<img src="https://rtview.com/wp-content/uploads/2016/10/mzl.tfigcody.png" style="display:inline-block; width:25px; "></a>
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
</div> ```



### e o script dentro do "head" do arquivo html:

```<script>
        function iframe(url){
                var jss3 = document.getElementsByClassName('jss3')[0];
                var div = jss3.childNodes[0];
                div.style.display = "block";
                div.innerHTML = '<iframe id="main-content" title="Main Content" frameborder="0" scrolling="yes" class="" src="'+url+'" style="width: 100%; height: 100%;"></iframe>';
                document.getElementById("main-content").src = url;
        };
</script>```
