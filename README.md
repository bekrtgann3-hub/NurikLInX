<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>Акции — сайт книги</title>
<link href="https://fonts.googleapis.com/css2?family=Unbounded:wght@500;800&family=Manrope:wght@400;600;800&family=Caveat:wght@600&display=swap" rel="stylesheet">
<style>
:root{--bg:#F6F7FA;--card:#FFFFFF;--ink:#12182B;--mute:#5E667B;--line:#DDE1EA;--brand:#FF4B3E;--mark:#FFD84D;--up:#14A06B;--deep:#12182B;--onDeep:#F6F7FA;
box-sizing:border-box;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}
@media (prefers-color-scheme:dark){:root:not([data-theme="light"]){--bg:#0D1120;--card:#161C30;--ink:#F1F3F9;--mute:#9AA3BA;--line:#2A3250;--up:#35C98C;--deep:#050812;--onDeep:#F1F3F9;color-scheme:dark}}
:root[data-theme="dark"]{--bg:#0D1120;--card:#161C30;--ink:#F1F3F9;--mute:#9AA3BA;--line:#2A3250;--up:#35C98C;--deep:#050812;--onDeep:#F1F3F9;color-scheme:dark}
html{scroll-behavior:smooth;scroll-padding-top:calc(76px + env(safe-area-inset-top,0px))}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--ink);font:17px/1.65 'Manrope',system-ui,sans-serif}
body::before{content:"";position:fixed;inset:0 0 auto;height:env(safe-area-inset-top,0px);background:var(--bg);z-index:30}
.wrap{max-width:1100px;margin:0 auto;padding:0 24px}
h1,h2,h3{font-family:'Unbounded',sans-serif;margin:0;line-height:1.05}
.hand{font-family:'Caveat','Segoe Script',cursive;font-weight:600;color:var(--brand)}
section{padding:110px 0}

/* nav */
nav{position:sticky;top:env(safe-area-inset-top,0px);z-index:20;background:color-mix(in srgb,var(--bg) 90%,transparent);backdrop-filter:blur(10px);border-bottom:1px solid var(--line)}
nav .wrap{display:flex;align-items:center;justify-content:space-between;height:68px;gap:16px}
.logo{font:800 22px 'Unbounded',sans-serif;color:var(--brand);text-decoration:none;transform:rotate(-2deg);display:inline-block}
nav ul{display:flex;gap:26px;list-style:none;margin:0;padding:0}
nav a{color:var(--ink);text-decoration:none;font-weight:800;font-size:14px}
nav ul a:hover{color:var(--brand)}
nav .buy{background:var(--ink);color:var(--bg);padding:10px 20px;border-radius:30px}
a:focus-visible,button:focus-visible,summary:focus-visible{outline:3px solid var(--brand);outline-offset:3px}

/* hero */
.hero{padding:70px 0 40px;position:relative;overflow:hidden}
.hero h1{font-size:clamp(76px,19vw,230px);font-weight:800;color:var(--brand);letter-spacing:-.04em;transform:rotate(-3deg);transform-origin:left;filter:url(#rough);margin-top:20px}
.by{font:800 15px 'Unbounded',sans-serif;transform:rotate(-3deg);margin:6px 0 0 8px}
.hero p.sub{font-size:22px;max-width:25em;margin:56px 0 28px}
.btn{display:inline-block;background:var(--brand);color:#fff;font:800 16px 'Unbounded',sans-serif;padding:18px 34px;border-radius:50px;text-decoration:none;border:0;cursor:pointer}
.btn:hover{background:var(--ink)}
.doodle{position:absolute;pointer-events:none}
.d1{right:6%;top:40px;width:min(430px,44vw)}
.d1 path.ln{stroke-dasharray:1100;stroke-dashoffset:1100;animation:draw 2.4s .3s ease-out forwards}
@keyframes draw{to{stroke-dashoffset:0}}
.note{position:absolute;font-size:28px;line-height:1.1;transform:rotate(-6deg)}
.n1{right:3%;top:20px}.n2{right:28%;top:250px;transform:rotate(4deg)}

/* idea */
.idea{background:var(--deep);color:var(--onDeep)}
.idea h2{font-size:clamp(30px,5vw,54px);max-width:15em}
.idea mark{background:var(--mark);color:#12182B;padding:0 .2em;border-radius:6px}
.facts{display:grid;grid-template-columns:repeat(3,1fr);gap:20px;margin-top:64px}
.fact{border-top:3px solid var(--brand);padding-top:16px}
.fact b{font:800 52px 'Unbounded',sans-serif;display:block;line-height:1}
.fact span{opacity:.75;display:block;margin-top:10px;font-size:15px}

/* chapters */
.head{display:flex;justify-content:space-between;align-items:end;gap:20px;margin-bottom:46px}
.head h2{font-size:clamp(30px,5vw,52px)}
details{border-top:2px solid var(--ink)}
details:last-of-type{border-bottom:2px solid var(--ink)}
summary{list-style:none;cursor:pointer;display:grid;grid-template-columns:90px 1fr 36px;align-items:center;gap:10px;padding:26px 0}
summary::-webkit-details-marker{display:none}
summary b{font:800 44px 'Unbounded',sans-serif;color:var(--brand)}
summary span{font:800 clamp(19px,3vw,28px) 'Unbounded',sans-serif}
summary::after{content:"+";font:500 36px 'Unbounded',sans-serif;transition:transform .25s;text-align:center}
details[open] summary::after{transform:rotate(45deg)}
summary:hover span{text-decoration:underline;text-decoration-color:var(--mark);text-decoration-thickness:5px}
details .body{padding:0 0 30px 100px;max-width:48em;color:var(--mute)}

/* book viewer */
.peek{background:color-mix(in srgb,var(--brand) 10%,var(--bg))}
.viewer{background:var(--card);border:2px solid var(--ink);border-radius:14px;box-shadow:10px 10px 0 var(--ink);overflow:hidden}
.spread{display:none;grid-template-columns:1fr 1fr;min-height:430px}
.spread.on{display:grid;animation:in .45s ease}
@keyframes in{from{opacity:0;transform:translateX(24px)}}
.pg{padding:44px 40px;position:relative}
.pg+.pg{border-left:1px dashed var(--line)}
.pg.dark{background:var(--deep);color:var(--onDeep)}
.pg.red{background:var(--brand);color:#fff}
.pg h3{font-size:30px;margin-bottom:18px}
.big{font:800 190px/1 'Unbounded',sans-serif;opacity:.25;position:absolute;bottom:-10px;right:20px}
.ln{height:10px;border-radius:5px;background:var(--line);margin:0 0 14px}
.pq{font:800 22px/1.3 'Unbounded',sans-serif;border-left:6px solid var(--mark);padding-left:18px;margin:24px 0}
.ctrl{display:flex;align-items:center;justify-content:center;gap:16px;margin-top:40px}
.ctrl button{width:52px;height:52px;border-radius:50%;border:2px solid var(--ink);background:var(--card);color:var(--ink);font-size:22px;cursor:pointer}
.ctrl button:hover{background:var(--ink);color:var(--bg)}
.dots{display:flex;gap:8px}.dots i{width:10px;height:10px;border-radius:50%;background:var(--line)}.dots i.on{background:var(--brand);width:30px;border-radius:6px}

/* glossary */
.chips{display:flex;flex-wrap:wrap;gap:12px;margin-bottom:28px}
.chips button{font:800 16px 'Manrope',sans-serif;padding:12px 22px;border-radius:40px;border:2px solid var(--ink);background:transparent;color:var(--ink);cursor:pointer}
.chips button[aria-pressed="true"]{background:var(--ink);color:var(--bg)}
.bubble{background:var(--card);border:2px solid var(--ink);border-radius:18px;padding:30px 34px;max-width:40em;position:relative;min-height:130px}
.bubble b{font:800 24px 'Unbounded',sans-serif;display:block;margin-bottom:8px}
.bubble::before{content:"";position:absolute;top:-14px;left:46px;width:24px;height:24px;background:var(--card);border-left:2px solid var(--ink);border-top:2px solid var(--ink);transform:rotate(45deg)}

footer{background:var(--brand);color:#fff;text-align:center;padding:100px 24px 80px}
footer h2{font-size:clamp(32px,6vw,64px);max-width:12em;margin:0 auto 30px}
footer .btn{background:#12182B}
footer p{margin:40px 0 0;opacity:.85;font-size:14px}

@media (max-width:760px){
 nav ul{display:none}
 section{padding:72px 0}
 .doodle,.note{display:none}
 .hero p.sub{margin-top:36px}
 .facts{grid-template-columns:1fr}
 summary{grid-template-columns:56px 1fr 30px}summary b{font-size:30px}
 details .body{padding-left:0}
 .spread{grid-template-columns:1fr;min-height:0}.pg+.pg{border-left:0;border-top:1px dashed var(--line)}
 .pg{padding:32px 24px}.big{font-size:130px}
}
@media (prefers-reduced-motion:reduce){html{scroll-behavior:auto}.d1 path.ln{animation:none;stroke-dashoffset:0}.spread.on{animation:none}}
</style>
</head>
<body>
<svg width="0" height="0" style="position:absolute" aria-hidden="true"><filter id="rough"><feTurbulence type="fractalNoise" baseFrequency=".05" numOctaves="2" seed="4" result="n"/><feDisplacementMap in="SourceGraphic" in2="n" scale="5"/></filter></svg>

<nav><div class="wrap">
  <a class="logo" href="#top">АКЦИИ</a>
  <ul><li><a href="#idea">О книге</a></li><li><a href="#chapters">Главы</a></li><li><a href="#peek">Полистать</a></li><li><a href="#terms">Словарь</a></li></ul>
  <a class="buy" href="#end">Читать</a>
</div></nav>

<header class="hero" id="top"><div class="wrap" style="position:relative">
  <svg class="doodle d1" viewBox="0 0 430 260" fill="none" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
    <path d="M10 250H420M10 250V10" stroke="var(--ink)" stroke-width="3"/>
    <path class="ln" d="M20 200 60 170 90 190 140 120 175 150 230 70 265 95 320 40 355 80 410 25" stroke="var(--up)" stroke-width="7"/>
    <circle cx="410" cy="25" r="11" fill="var(--mark)" stroke="var(--ink)" stroke-width="3"/>
  </svg>
  <span class="hand note n1">вот сюда<br>мы придём</span>
  <span class="hand note n2">а вдруг упадёт?</span>
  <h1>АКЦИИ</h1>
  <p class="by">КНИГА О БИРЖЕ · АВТОР: ИМЯ ФАМИЛИЯ</p>
  <p class="sub">Здесь будет короткий слоган: одна мысль о том, зачем читателю эта книга и что он поймёт к последней странице.</p>
  <a class="btn" href="#chapters">Начать читать</a>
</div></header>

<section class="idea" id="idea"><div class="wrap">
  <h2>Здесь будет главная идея книги: <mark>без страха и сложных слов</mark>, шаг за шагом.</h2>
  <div class="facts">
    <div class="fact"><b>5</b><span>глав: от первой покупки до первого портфеля</span></div>
    <div class="fact"><b>120</b><span>страниц примеров, схем и историй</span></div>
    <div class="fact"><b>30</b><span>терминов, объяснённых простыми словами</span></div>
  </div>
</div></section>

<section id="chapters"><div class="wrap">
  <div class="head"><h2>Главы</h2><span class="hand" style="font-size:30px">нажми, чтобы заглянуть</span></div>
  <details open><summary><b>1</b><span>Что такое акция</span></summary><div class="body">Здесь будет короткий анонс главы на 2–3 строки. Он должен обещать читателю ответ на вопрос.</div></details>
  <details><summary><b>2</b><span>Как работает биржа</span></summary><div class="body">Здесь будет короткий анонс второй главы.</div></details>
  <details><summary><b>3</b><span>Рынок растёт и падает</span></summary><div class="body">Здесь будет короткий анонс третьей главы.</div></details>
  <details><summary><b>4</b><span>Первая покупка</span></summary><div class="body">Здесь будет короткий анонс четвёртой главы.</div></details>
  <details><summary><b>5</b><span>Ошибки новичков</span></summary><div class="body">Здесь будет короткий анонс пятой главы.</div></details>
</div></section>

<section class="peek" id="peek"><div class="wrap">
  <div class="head"><h2>Полистать</h2><span class="hand" style="font-size:30px">так выглядят страницы</span></div>
  <div class="viewer" id="viewer">
    <div class="spread on">
      <div class="pg red"><h3>Глава 1</h3><p>Здесь будет вступление к главе: одна яркая фраза.</p><span class="big">1</span></div>
      <div class="pg"><h3>Что такое акция</h3><div class="ln" style="width:100%"></div><div class="ln" style="width:92%"></div><div class="ln" style="width:97%"></div><div class="ln" style="width:60%"></div><div class="pq">Здесь будет главная мысль страницы.</div><div class="ln" style="width:95%"></div><div class="ln" style="width:70%"></div></div>
    </div>
    <div class="spread">
      <div class="pg"><h3>Цифры</h3><svg viewBox="0 0 300 160" fill="none" stroke-width="5" stroke-linecap="round" stroke-linejoin="round" style="width:100%"><path d="M0 150H300" stroke="var(--line)"/><path d="M5 130 50 110 90 120 140 70 190 90 240 30 295 15" stroke="var(--up)"/></svg><div class="ln" style="width:90%"></div><div class="ln" style="width:75%"></div></div>
      <div class="pg dark"><h3>Запомните</h3><p>Здесь будет вывод в одну-две строки: то, что читатель унесёт из раздела.</p><div class="pq" style="border-color:var(--brand)">+12%</div></div>
    </div>
    <div class="spread">
      <div class="pg"><h3>Шаги</h3><div class="ln" style="width:80%"></div><div class="ln" style="width:90%"></div><div class="ln" style="width:70%"></div><div class="ln" style="width:85%"></div></div>
      <div class="pg red"><h3>Что дальше?</h3><p>Страница заканчивается вопросом, ответ на который в следующей главе.</p><span class="big">?</span></div>
    </div>
  </div>
  <div class="ctrl"><button id="prev" aria-label="Назад">←</button><div class="dots"><i class="on"></i><i></i><i></i></div><button id="next" aria-label="Вперёд">→</button></div>
</div></section>

<section id="terms"><div class="wrap">
  <div class="head"><h2>Словарь</h2><span class="hand" style="font-size:30px">без занудства</span></div>
  <div class="chips" id="chips"></div>
  <div class="bubble" id="bubble"></div>
</div></section>

<footer id="end">
  <h2>Первая глава уже ждёт тебя</h2>
  <a class="btn" href="#chapters">Читать главу 1</a>
  <p>© Имя Фамилия, 2026. Это макет: тексты заменим на настоящие.</p>
</footer>

<script>
(function(){
 var sp=[].slice.call(document.querySelectorAll('.spread')),dots=[].slice.call(document.querySelectorAll('.dots i')),k=0;
 function go(n){k=(n+sp.length)%sp.length;sp.forEach(function(s,i){s.classList.toggle('on',i===k)});dots.forEach(function(d,i){d.classList.toggle('on',i===k)})}
 document.getElementById('prev').onclick=function(){go(k-1)};
 document.getElementById('next').onclick=function(){go(k+1)};
 var T=[['Акция','Здесь будет определение: доля в компании, которую можно купить и продать.'],['Дивиденд','Здесь будет определение: часть прибыли, которую компания платит владельцам акций.'],['Брокер','Здесь будет определение: посредник, через которого вы покупаете акции.'],['Индекс','Здесь будет определение: число, которое показывает, как живёт целый рынок.'],['Портфель','Здесь будет определение: всё, что вы купили, собранное вместе.']],
 c=document.getElementById('chips'),b=document.getElementById('bubble');
 function show(i){[].forEach.call(c.children,function(x,j){x.setAttribute('aria-pressed',j===i)});b.innerHTML='<b>'+T[i][0]+'</b>'+T[i][1]}
 T.forEach(function(t,i){var x=document.createElement('button');x.textContent=t[0];x.onclick=function(){show(i)};c.appendChild(x)});
 show(0);
})();
</script>
</body>
</html>
