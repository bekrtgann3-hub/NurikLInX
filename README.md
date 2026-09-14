<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Кофейня в холле университета — 3D проект</title>
<style>
  :root{
    --espresso:#2b1c14;
    --espresso-2:#3e2b1f;
    --cream:#efe4d3;
    --brass:#b8874f;
    --sage:#7c8a6b;
    --terracotta:#a85c37;
    --panel-bg: rgba(20,13,9,0.72);
  }
  *{box-sizing:border-box;}
  html,body{
    margin:0; padding:0; width:100%; height:100%;
    background:var(--espresso);
    font-family: 'Georgia', 'Iowan Old Style', serif;
    overflow:hidden;
  }
  #scene-container{
    position:absolute; inset:0;
  }
  canvas{ display:block; touch-action:none; }

  .panel{
    position:absolute;
    background:var(--panel-bg);
    backdrop-filter: blur(6px);
    border:1px solid rgba(184,135,79,0.35);
    color:var(--cream);
    border-radius:2px;
  }

  #title-panel{
    top:22px; left:22px;
    padding:18px 22px;
    max-width:330px;
  }
  #title-panel h1{
    margin:0 0 6px 0;
    font-size:22px;
    font-weight:600;
    letter-spacing:0.3px;
    color:#f4ead9;
  }
  #title-panel p{
    margin:0;
    font-size:13.5px;
    line-height:1.55;
    color:#d8c9b3;
    font-family: -apple-system, 'Helvetica Neue', Arial, sans-serif;
  }
  #title-panel .dims{
    margin-top:10px;
    padding-top:10px;
    border-top:1px solid rgba(184,135,79,0.3);
    font-family: -apple-system, 'Helvetica Neue', Arial, sans-serif;
    font-size:12.5px;
    color:var(--brass);
  }

  #controls-panel{
    bottom:22px; left:22px;
    padding:12px 14px;
    display:flex;
    gap:8px;
    flex-wrap:wrap;
    max-width:280px;
    font-family: -apple-system, 'Helvetica Neue', Arial, sans-serif;
  }
  #controls-panel button{
    background:transparent;
    border:1px solid rgba(184,135,79,0.5);
    color:var(--cream);
    padding:7px 12px;
    font-size:12px;
    border-radius:2px;
    cursor:pointer;
    transition: background 0.2s, border-color 0.2s;
    font-family: inherit;
  }
  #controls-panel button:hover{
    background:rgba(184,135,79,0.22);
    border-color:var(--brass);
  }
  #controls-panel button.active{
    background:var(--brass);
    color:var(--espresso);
    border-color:var(--brass);
  }

  #hint{
    position:absolute;
    bottom:22px; right:22px;
    padding:10px 14px;
    font-size:12px;
    color:#c9b8a0;
    font-family: -apple-system, 'Helvetica Neue', Arial, sans-serif;
    max-width:200px;
    text-align:right;
    line-height:1.5;
  }

  #legend{
    top:22px; right:22px;
    padding:14px 16px;
    font-family: -apple-system, 'Helvetica Neue', Arial, sans-serif;
    font-size:12px;
    color:#d8c9b3;
    line-height:2;
  }
  #legend .dot{
    display:inline-block;
    width:9px; height:9px;
    border-radius:50%;
    margin-right:8px;
  }

  #loading{
    position:absolute; inset:0;
    display:flex; align-items:center; justify-content:center;
    background:var(--espresso);
    color:var(--cream);
    font-family: -apple-system, 'Helvetica Neue', Arial, sans-serif;
    font-size:14px;
    letter-spacing:1px;
    z-index:10;
    transition: opacity 0.6s ease;
  }

  @media (max-width: 640px){
    #legend{ display:none; }
    #title-panel{ max-width: 78vw; padding:14px 16px; }
    #title-panel h1{ font-size:18px; }
    #hint{ display:none; }
    #controls-panel{ max-width: 60vw; }
  }
</style>
</head>
<body>

<div id="loading">ЗАГРУЗКА ИНТЕРЬЕРА…</div>

<div id="scene-container"></div>

<div class="panel" id="title-panel">
  <h1>Кофейня в холле университета</h1>
  <p>Компактная кофейня у одной несущей стены холла: задняя рабочая стойка у стены с кофемашинами и ингредиентами, клиентская стойка с десертами и выпечкой, проход для бариста между ними, барные стулья у клиентской стойки — формат с обслуживанием, без самообслуживания.</p>
  <div class="dims">Ширина: 4 м · Длина: 3 м · Одна стена, вторая сторона открыта в холл</div>
</div>

<div class="panel" id="legend">
  <div><span class="dot" style="background:#b8874f"></span>Стойка и латунь</div>
  <div><span class="dot" style="background:#a85c37"></span>Напольная плитка</div>
  <div><span class="dot" style="background:#7c8a6b"></span>Растения</div>
  <div><span class="dot" style="background:#efe4d3"></span>Стены холла</div>
</div>

<div class="panel" id="controls-panel">
  <button id="btn-orbit" class="active">Обзор</button>
  <button id="btn-front">Спереди</button>
  <button id="btn-top">Сверху</button>
  <button id="btn-side">Сбоку</button>
  <button id="btn-auto">Авто-вращение</button>
  <button id="btn-time">Вечер</button>
</div>

<div id="hint">Зажмите и потяните — вращение<br>Колесо мыши — приближение</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
<script>
(function(){

  var container = document.getElementById('scene-container');
  var W = window.innerWidth, H = window.innerHeight;

  // ---------- базовая сцена ----------
  var scene = new THREE.Scene();
  scene.background = new THREE.Color(0x1c130d);
  scene.fog = new THREE.Fog(0x1c130d, 9, 22);

  var camera = new THREE.PerspectiveCamera(45, W/H, 0.1, 100);
  var target = new THREE.Vector3(0, 1.3, -1);

  var renderer = new THREE.WebGLRenderer({antialias:true});
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
  renderer.setSize(W, H);
  renderer.shadowMap.enabled = true;
  renderer.shadowMap.type = THREE.PCFSoftShadowMap;
  renderer.outputEncoding = THREE.sRGBEncoding;
  container.appendChild(renderer.domElement);

  // ---------- простое орбитальное управление (без внешних зависимостей) ----------
  var spherical = { radius: 5, theta: Math.PI*0.32, phi: Math.PI*0.38 };
  var isDragging = false, lastX=0, lastY=0;
  var autoRotate = false;

  function updateCameraFromSpherical(){
    spherical.phi = Math.max(0.18, Math.min(Math.PI/2 - 0.02, spherical.phi));
    spherical.radius = Math.max(3, Math.min(18, spherical.radius));
    var x = target.x + spherical.radius * Math.sin(spherical.phi) * Math.sin(spherical.theta);
    var y = target.y + spherical.radius * Math.cos(spherical.phi);
    var z = target.z + spherical.radius * Math.sin(spherical.phi) * Math.cos(spherical.theta);
    camera.position.set(x,y,z);
    camera.lookAt(target);
  }
  updateCameraFromSpherical();

  renderer.domElement.addEventListener('pointerdown', function(e){
    isDragging = true; lastX = e.clientX; lastY = e.clientY;
    setOrbitButtonActive();
  });
  window.addEventListener('pointerup', function(){ isDragging = false; });
  window.addEventListener('pointermove', function(e){
    if(!isDragging) return;
    var dx = e.clientX - lastX, dy = e.clientY - lastY;
    lastX = e.clientX; lastY = e.clientY;
    spherical.theta -= dx * 0.006;
    spherical.phi -= dy * 0.006;
    updateCameraFromSpherical();
  });
  renderer.domElement.addEventListener('wheel', function(e){
    e.preventDefault();
    spherical.radius += e.deltaY * 0.01;
    updateCameraFromSpherical();
  }, {passive:false});

  window.addEventListener('resize', function(){
    W = window.innerWidth; H = window.innerHeight;
    camera.aspect = W/H;
    camera.updateProjectionMatrix();
    renderer.setSize(W,H);
  });

  // ---------- материалы ----------
  function canvasTexture(draw, w, h, repeatX, repeatY){
    var c = document.createElement('canvas'); c.width=w; c.height=h;
    var ctx = c.getContext('2d');
    draw(ctx, w, h);
    var tex = new THREE.CanvasTexture(c);
    tex.wrapS = tex.wrapT = THREE.RepeatWrapping;
    tex.repeat.set(repeatX||1, repeatY||1);
    tex.encoding = THREE.sRGBEncoding;
    return tex;
  }

  var floorTex = canvasTexture(function(ctx,w,h){
    ctx.fillStyle = '#8a4a2e'; ctx.fillRect(0,0,w,h);
    var tile = 64;
    for(var y=0;y<h;y+=tile){
      for(var x=0;x<w;x+=tile){
        var shade = (Math.floor(x/tile)+Math.floor(y/tile))%2===0 ? '#a85c37' : '#96502f';
        ctx.fillStyle = shade;
        ctx.fillRect(x+1,y+1,tile-2,tile-2);
      }
    }
  }, 512,512, 3, 7);
  var floorMat = new THREE.MeshStandardMaterial({map:floorTex, roughness:0.85, metalness:0.05});

  var wallTex = canvasTexture(function(ctx,w,h){
    ctx.fillStyle = '#efe4d3'; ctx.fillRect(0,0,w,h);
    ctx.strokeStyle = 'rgba(0,0,0,0.04)';
    for(var i=0;i<400;i++){
      ctx.beginPath();
      ctx.moveTo(Math.random()*w, Math.random()*h);
      ctx.lineTo(Math.random()*w, Math.random()*h);
      ctx.stroke();
    }
  }, 256,256,2,2);
  var wallMat = new THREE.MeshStandardMaterial({map:wallTex, roughness:0.95});
  var wallLowerMat = new THREE.MeshStandardMaterial({color:0x5a3d2b, roughness:0.8});

  var woodMat = new THREE.MeshStandardMaterial({color:0x6b4226, roughness:0.55, metalness:0.05});
  var darkWoodMat = new THREE.MeshStandardMaterial({color:0x3e2723, roughness:0.5, metalness:0.05});
  var counterTopMat = new THREE.MeshStandardMaterial({color:0x2b1c14, roughness:0.35, metalness:0.15});
  var brassMat = new THREE.MeshStandardMaterial({color:0xb8874f, roughness:0.3, metalness:0.85});
  var steelMat = new THREE.MeshStandardMaterial({color:0xcfcfcf, roughness:0.25, metalness:0.9});
  var glassMat = new THREE.MeshPhysicalMaterial({color:0xffffff, transparent:true, opacity:0.18, roughness:0.05, metalness:0, transmission:0.6});
  var blackMat = new THREE.MeshStandardMaterial({color:0x1a1a1a, roughness:0.4, metalness:0.4});
  var sageMat = new THREE.MeshStandardMaterial({color:0x7c8a6b, roughness:0.9});
  var potMat = new THREE.MeshStandardMaterial({color:0xa85c37, roughness:0.8});
  var creamMat = new THREE.MeshStandardMaterial({color:0xf4ead9, roughness:0.6});
  var menuBoardMat = new THREE.MeshStandardMaterial({color:0x241812, roughness:0.7});

  // ---------- геометрия помещения ----------
  var CORRIDOR_WIDTH = 4;   // между стенами
  var CORRIDOR_LENGTH = 3;
  var WALL_HEIGHT = 3;
  var halfW = CORRIDOR_WIDTH/2;
  var backZ = -CORRIDOR_LENGTH/2;
  var frontZ = CORRIDOR_LENGTH/2;

  // рабочая зона бариста и барная стойка (не самообслуживание)
  var BACK_COUNTER_D = 0.45;                               // глубина задней рабочей стойки у стены (оборудование, ингредиенты)
  var backCounterZ = backZ + 0.08 + BACK_COUNTER_D/2;       // почти вплотную к задней стене
  var backCounterFrontZ = backCounterZ + BACK_COUNTER_D/2;  // передняя грань задней стойки

  var WORK_GAP = 0.75;                                     // проход для бариста между двумя стойками
  var COUNTER_D = 0.5;                                     // толщина клиентской (фронтальной) стойки
  var counterZ = backCounterFrontZ + WORK_GAP + COUNTER_D/2;  // центр клиентской стойки по глубине
  var counterFrontZ = counterZ + COUNTER_D/2;               // передняя грань клиентской стойки (к посетителям)
  var baristaZ = backCounterFrontZ + WORK_GAP/2;            // бариста работают в проходе между стойками

  var room = new THREE.Group();
  scene.add(room);

  // пол
  var floor = new THREE.Mesh(new THREE.BoxGeometry(CORRIDOR_WIDTH, 0.1, CORRIDOR_LENGTH), floorMat);
  floor.position.set(0,-0.05,0);
  floor.receiveShadow = true;
  room.add(floor);

  // плинтус + стены (левая/правая)
  function buildWall(xSign){
    var g = new THREE.Group();
    var wall = new THREE.Mesh(new THREE.BoxGeometry(0.2, WALL_HEIGHT, CORRIDOR_LENGTH), wallMat);
    wall.position.set(xSign*(halfW+0.1), WALL_HEIGHT/2, 0);
    wall.receiveShadow = true; wall.castShadow = true;
    g.add(wall);
    var base = new THREE.Mesh(new THREE.BoxGeometry(0.22, 0.5, CORRIDOR_LENGTH), wallLowerMat);
    base.position.set(xSign*(halfW+0.11), 0.25, 0);
    g.add(base);
    return g;
  }
  room.add(buildWall(-1));
  // правая стена убрана — кофейня открыта в сторону холла

  // потолок (тёмный, с балками)
  var ceiling = new THREE.Mesh(new THREE.BoxGeometry(CORRIDOR_WIDTH, 0.1, CORRIDOR_LENGTH), new THREE.MeshStandardMaterial({color:0x241812, roughness:0.9}));
  ceiling.position.set(0, WALL_HEIGHT, 0);
  room.add(ceiling);
  for(var bz=backZ+0.6; bz<frontZ; bz+=1.5){
    var beam = new THREE.Mesh(new THREE.BoxGeometry(CORRIDOR_WIDTH-0.1, 0.14, 0.14), darkWoodMat);
    beam.position.set(0, WALL_HEIGHT-0.07, bz);
    room.add(beam);
  }

  // задняя стена с проёмом под стойку
  var backWall = new THREE.Mesh(new THREE.BoxGeometry(CORRIDOR_WIDTH, WALL_HEIGHT, 0.15), wallMat);
  backWall.position.set(0, WALL_HEIGHT/2, backZ-0.05);
  backWall.receiveShadow = true;
  room.add(backWall);

  // ---------- стойка кофейни ----------
  var counter = new THREE.Group();
  var counterBaseW = 3.2, counterD = COUNTER_D, counterH = 1.05;
  var base = new THREE.Mesh(new THREE.BoxGeometry(counterBaseW, counterH, counterD), woodMat);
  base.position.set(0, counterH/2, counterZ);
  base.castShadow = true; base.receiveShadow = true;
  counter.add(base);
  var top = new THREE.Mesh(new THREE.BoxGeometry(counterBaseW+0.08, 0.06, counterD+0.1), counterTopMat);
  top.position.set(0, counterH+0.03, counterZ);
  top.castShadow = true;
  counter.add(top);
  // латунная полоска-декор
  var strip = new THREE.Mesh(new THREE.BoxGeometry(counterBaseW-0.1, 0.03, 0.03), brassMat);
  strip.position.set(0, 0.35, counterZ+counterD/2-0.02);
  counter.add(strip);
  // деревянные панели-рейки на фасаде стойки
  for(var px=-counterBaseW/2+0.15; px<counterBaseW/2; px+=0.16){
    var slat = new THREE.Mesh(new THREE.BoxGeometry(0.06, counterH-0.1, 0.02), darkWoodMat);
    slat.position.set(px, counterH/2, counterZ+counterD/2+0.01);
    counter.add(slat);
  }
  room.add(counter);

  // ---------- задняя рабочая стойка у стены (оборудование, ингредиенты, кофемашины) ----------
  var backCounter = new THREE.Group();
  var backCounterBaseW = 3.2;
  var backBase = new THREE.Mesh(new THREE.BoxGeometry(backCounterBaseW, counterH, BACK_COUNTER_D), woodMat);
  backBase.position.set(0, counterH/2, backCounterZ);
  backBase.castShadow = true; backBase.receiveShadow = true;
  backCounter.add(backBase);
  var backTop = new THREE.Mesh(new THREE.BoxGeometry(backCounterBaseW+0.06, 0.05, BACK_COUNTER_D+0.06), counterTopMat);
  backTop.position.set(0, counterH+0.025, backCounterZ);
  backTop.castShadow = true;
  backCounter.add(backTop);
  room.add(backCounter);

  // ингредиенты и расходники (банки/канистры) на задней стойке
  function buildIngredientJar(x, r, h, mat){
    var jar = new THREE.Mesh(new THREE.CylinderGeometry(r, r, h, 14), mat);
    jar.position.set(x, counterH+0.05+h/2, backCounterZ+0.08);
    jar.castShadow = true;
    var lid = new THREE.Mesh(new THREE.CylinderGeometry(r*0.85, r*0.85, 0.015, 14), brassMat);
    lid.position.set(x, counterH+0.05+h+0.008, backCounterZ+0.08);
    return [jar, lid];
  }
  var jarMats = [creamMat, new THREE.MeshStandardMaterial({color:0x4a3527, roughness:0.6}), steelMat, new THREE.MeshStandardMaterial({color:0xd8c9a8, roughness:0.5})];
  [ {x:0.0,r:0.06,h:0.2}, {x:0.42,r:0.07,h:0.24}, {x:0.86,r:0.055,h:0.17}, {x:1.3,r:0.08,h:0.28}, {x:1.55,r:0.05,h:0.15} ].forEach(function(j,i){
    buildIngredientJar(j.x, j.r, j.h, jarMats[i%jarMats.length]).forEach(function(m){ room.add(m); });
  });

  // кофемашина
  function buildCoffeeMachine(x){
    var g = new THREE.Group();
    var bodyMat = blackMat;
    var body = new THREE.Mesh(new THREE.BoxGeometry(0.5, 0.42, 0.42), bodyMat);
    body.position.y = counterH+0.06+0.21;
    body.castShadow = true;
    g.add(body);
    var group1 = new THREE.Mesh(new THREE.CylinderGeometry(0.03,0.03,0.16,10), steelMat);
    group1.position.set(-0.12, counterH+0.06-0.02, 0.24);
    g.add(group1);
    var group2 = group1.clone(); group2.position.x = 0.12;
    g.add(group2);
    var gauge = new THREE.Mesh(new THREE.CylinderGeometry(0.045,0.045,0.02,16), brassMat);
    gauge.rotation.x = Math.PI/2;
    gauge.position.set(0, counterH+0.06+0.34, 0.22);
    g.add(gauge);
    g.position.set(x, 0, backCounterZ-0.02);
    return g;
  }
  room.add(buildCoffeeMachine(-1.3));
  room.add(buildCoffeeMachine(-0.55));

  // витрина с выпечкой (стекло)
  function buildPastryCase(x){
    var g = new THREE.Group();
    var frameMat = darkWoodMat;
    var w=0.7,d=0.4,h=0.42;
    var glassBox = new THREE.Mesh(new THREE.BoxGeometry(w,h,d), glassMat);
    glassBox.position.y = counterH+0.06+h/2;
    g.add(glassBox);
    // рамки
    var edges = new THREE.LineSegments(new THREE.EdgesGeometry(new THREE.BoxGeometry(w,h,d)), new THREE.LineBasicMaterial({color:0x2b1c14}));
    edges.position.y = counterH+0.06+h/2;
    g.add(edges);
    // полка внутри
    var shelf = new THREE.Mesh(new THREE.BoxGeometry(w-0.05,0.02,d-0.05), woodMat);
    shelf.position.y = counterH+0.06+0.15;
    g.add(shelf);
    // выпечка и десерты (маленькие торы/сферы разных цветов — круассаны, эклеры, тарты)
    var pastryColors = [0xc9915a,0xdbb37a,0x9a5a34,0x7a4030];
    for(var i=0;i<5;i++){
      var pMat = new THREE.MeshStandardMaterial({color:pastryColors[i%4], roughness:0.7});
      var p = new THREE.Mesh(new THREE.SphereGeometry(0.048,10,8), pMat);
      p.scale.y = 0.6;
      p.position.set(-w/2+0.09+i*0.13, counterH+0.06+0.18, 0);
      g.add(p);
    }
    g.position.set(x,0,counterZ-0.02);
    return g;
  }
  room.add(buildPastryCase(1.0));

  // отдельная витрина-стойка с десертами (двухъярусная — торты/пирожные)
  function buildDessertStand(x){
    var g = new THREE.Group();
    var cakeColors = [0xf4ead9,0xc9915a,0x8a4a2e];
    // нижний ярус
    var tier1 = new THREE.Mesh(new THREE.CylinderGeometry(0.16,0.17,0.1,20), new THREE.MeshStandardMaterial({color:cakeColors[0], roughness:0.6}));
    tier1.position.y = counterH+0.06+0.08;
    g.add(tier1);
    var icing1 = new THREE.Mesh(new THREE.CylinderGeometry(0.16,0.16,0.02,20), new THREE.MeshStandardMaterial({color:cakeColors[1], roughness:0.5}));
    icing1.position.y = counterH+0.06+0.14;
    g.add(icing1);
    // ножка стенда
    var pole = new THREE.Mesh(new THREE.CylinderGeometry(0.018,0.018,0.16,10), brassMat);
    pole.position.y = counterH+0.06+0.22;
    g.add(pole);
    // верхний ярус — пирожные
    var plate = new THREE.Mesh(new THREE.CylinderGeometry(0.13,0.13,0.015,20), brassMat);
    plate.position.y = counterH+0.06+0.30;
    g.add(plate);
    for(var i=0;i<3;i++){
      var ang = (i/3)*Math.PI*2;
      var cake = new THREE.Mesh(new THREE.SphereGeometry(0.045,10,8), new THREE.MeshStandardMaterial({color:cakeColors[i%3], roughness:0.65}));
      cake.scale.y = 0.7;
      cake.position.set(Math.cos(ang)*0.07, counterH+0.06+0.335, Math.sin(ang)*0.07);
      g.add(cake);
    }
    g.position.set(x,0,counterZ+0.02);
    return g;
  }
  room.add(buildDessertStand(0.35));

  // стопки стаканов/чашек на стойке
  function buildCupStack(x,z){
    var g = new THREE.Group();
    for(var i=0;i<3;i++){
      var cup = new THREE.Mesh(new THREE.CylinderGeometry(0.035,0.03,0.06,12), creamMat);
      cup.position.set(0, counterH+0.06+0.03+i*0.062, 0);
      g.add(cup);
    }
    g.position.set(x,0,z);
    return g;
  }
  room.add(buildCupStack(-1.5, counterZ-0.03));
  room.add(buildCupStack(1.5, counterZ+0.03));

  // полки над стойкой
  function buildShelfUnit(){
    var g = new THREE.Group();
    for(var i=0;i<2;i++){
      var shelf = new THREE.Mesh(new THREE.BoxGeometry(2.6,0.04,0.22), woodMat);
      shelf.position.set(0, 1.85+i*0.5, backZ+0.02);
      shelf.castShadow = true;
      g.add(shelf);
      // держатели
      var holderMat = brassMat;
      for(var hx=-1.2; hx<=1.2; hx+=1.2){
        var holder = new THREE.Mesh(new THREE.BoxGeometry(0.02,0.04,0.02), holderMat);
        holder.position.set(hx, 1.85+i*0.5-0.02, backZ+0.02+0.09);
        g.add(holder);
      }
      // чашки/банки на полке
      for(var j=0;j<5;j++){
        var jarMat = j%2===0 ? creamMat : new THREE.MeshStandardMaterial({color:0x4a3527, roughness:0.6});
        var jar = new THREE.Mesh(new THREE.CylinderGeometry(0.05,0.05,0.12,10), jarMat);
        jar.position.set(-1.1+j*0.5, 1.85+i*0.5+0.08, backZ+0.02);
        g.add(jar);
      }
    }
    return g;
  }
  room.add(buildShelfUnit());

  // меню на стене (доска с текстурой)
  var menuTex = canvasTexture(function(ctx,w,h){
    ctx.fillStyle = '#241812'; ctx.fillRect(0,0,w,h);
    ctx.strokeStyle = '#b8874f'; ctx.lineWidth = 6;
    ctx.strokeRect(10,10,w-20,h-20);
    ctx.fillStyle = '#f4ead9';
    ctx.font = '600 34px Georgia';
    ctx.textAlign = 'center';
    ctx.fillText('МЕНЮ', w/2, 55);
    ctx.font = '20px Georgia';
    ctx.textAlign = 'left';
    var items = ['Эспрессо', 'Капучино', 'Латте', 'Раф', 'Круассан', 'Чизкейк'];
    items.forEach(function(t,i){
      ctx.fillText('• '+t, 30, 100 + i*32);
    });
  }, 380, 340, 1,1);
  var menuBoard = new THREE.Mesh(new THREE.PlaneGeometry(1.1,1.0), new THREE.MeshStandardMaterial({map:menuTex, roughness:0.8}));
  menuBoard.position.set(0, 2.45, backZ+0.04);
  room.add(menuBoard);

  // подвесной светильник над стойкой (общая функция)
  function buildPendant(x,z, on){
    var g = new THREE.Group();
    var cord = new THREE.Mesh(new THREE.CylinderGeometry(0.006,0.006, WALL_HEIGHT-1.55, 6), blackMat);
    cord.position.set(0, WALL_HEIGHT-(WALL_HEIGHT-1.55)/2, 0);
    g.add(cord);
    var shadeMat = brassMat;
    var shade = new THREE.Mesh(new THREE.ConeGeometry(0.14,0.13,16,1,true), shadeMat);
    shade.rotation.x = Math.PI;
    shade.position.set(0, 1.53, 0);
    g.add(shade);
    var bulb = new THREE.Mesh(new THREE.SphereGeometry(0.035,10,10), new THREE.MeshStandardMaterial({color:0xfff3d0, emissive:0xffcf80, emissiveIntensity:1.2}));
    bulb.position.set(0, 1.46, 0);
    g.add(bulb);
    var light = new THREE.PointLight(0xffcf8a, on?0.9:0.0, 4.5, 2);
    light.position.set(0, 1.46, 0);
    light.castShadow = true;
    g.add(light);
    g.position.set(x,0,z);
    g.userData.light = light;
    g.userData.bulb = bulb;
    return g;
  }
  var pendants = [];
  [ -0.9, 0.9 ].forEach(function(x){
    var p = buildPendant(x, backCounterZ, true);
    room.add(p); pendants.push(p);
  });
  [counterZ, 0.3, 0.9].forEach(function(z){
    var p = buildPendant(0, z, true);
    room.add(p); pendants.push(p);
  });

  // барные стулья прямо у стойки — гости сидят лицом к бариста (посадка у бара, без отдельных столов)
  function buildStool(x,z, rotY){
    var g = new THREE.Group();
    var seat = new THREE.Mesh(new THREE.CylinderGeometry(0.15,0.15,0.04,20), darkWoodMat);
    seat.position.y = 0.72;
    seat.castShadow = true;
    g.add(seat);
    var pole = new THREE.Mesh(new THREE.CylinderGeometry(0.025,0.03,0.68,10), brassMat);
    pole.position.y = 0.38;
    g.add(pole);
    var ring = new THREE.Mesh(new THREE.TorusGeometry(0.13,0.008,8,20), brassMat);
    ring.rotation.x = Math.PI/2;
    ring.position.y = 0.28;
    g.add(ring);
    var base2 = new THREE.Mesh(new THREE.CylinderGeometry(0.13,0.13,0.02,20), blackMat);
    g.add(base2);
    g.position.set(x,0,z);
    g.rotation.y = rotY||0;
    return g;
  }

  var stoolXs = [-1.3, -0.65, 0, 0.65, 1.3];
  stoolXs.forEach(function(sx){
    room.add(buildStool(sx, counterFrontZ+0.38));
  });

  // растения в кадках у входа
  function buildPlant(x,z){
    var g = new THREE.Group();
    var pot = new THREE.Mesh(new THREE.CylinderGeometry(0.16,0.12,0.28,14), potMat);
    pot.position.y = 0.14;
    pot.castShadow = true;
    g.add(pot);
    var trunk = new THREE.Mesh(new THREE.CylinderGeometry(0.02,0.025,0.35,8), darkWoodMat);
    trunk.position.y = 0.28+0.17;
    g.add(trunk);
    for(var i=0;i<6;i++){
      var leaf = new THREE.Mesh(new THREE.SphereGeometry(0.14,8,8), sageMat);
      leaf.scale.set(1,1.4,0.4);
      var ang = (i/6)*Math.PI*2;
      leaf.position.set(Math.cos(ang)*0.1, 0.62+Math.random()*0.15, Math.sin(ang)*0.1);
      leaf.rotation.z = ang;
      g.add(leaf);
    }
    g.position.set(x,0,z);
    return g;
  }
  room.add(buildPlant(-halfW+0.35, frontZ-0.5));
  room.add(buildPlant(halfW-0.35, frontZ-0.5));

  // гирлянда светящихся точек вдоль потолка (создаёт уют)
  var stringGroup = new THREE.Group();
  var stringMat = new THREE.MeshStandardMaterial({color:0xfff0c8, emissive:0xffcf80, emissiveIntensity:1.3});
  for(var s=backZ+0.3; s<frontZ; s+=0.35){
    var sag = Math.sin(((s-backZ)/CORRIDOR_LENGTH)*Math.PI*4)*0.03;
    var bulb1 = new THREE.Mesh(new THREE.SphereGeometry(0.014,6,6), stringMat);
    bulb1.position.set(-halfW+0.05, WALL_HEIGHT-0.12+sag, s);
    stringGroup.add(bulb1);
    var bulb2 = bulb1.clone();
    bulb2.position.x = halfW-0.05;
    stringGroup.add(bulb2);
  }
  room.add(stringGroup);

  // стеклянный вход в конце коридора (лёгкий намёк на холл университета)
  var doorFrame = new THREE.Group();
  var frameMatD = darkWoodMat;
  var lf = new THREE.Mesh(new THREE.BoxGeometry(0.08, WALL_HEIGHT, 0.08), frameMatD);
  lf.position.set(-halfW+0.06, WALL_HEIGHT/2, frontZ-0.05);
  doorFrame.add(lf);
  var rf = lf.clone(); rf.position.x = halfW-0.06;
  doorFrame.add(rf);
  var glassPane = new THREE.Mesh(new THREE.PlaneGeometry(CORRIDOR_WIDTH-0.2, WALL_HEIGHT-0.1), glassMat);
  glassPane.position.set(0, WALL_HEIGHT/2, frontZ-0.05);
  doorFrame.add(glassPane);
  room.add(doorFrame);

  // ---------- фигура бариста за стойкой ----------
  function buildBarista(x,z, rotY){
    var g = new THREE.Group();
    var skinMat = new THREE.MeshStandardMaterial({color:0xd8a878, roughness:0.7});
    var shirtMat = new THREE.MeshStandardMaterial({color:0xf4ead9, roughness:0.75});
    var apronMat = new THREE.MeshStandardMaterial({color:0x3e2b1f, roughness:0.65});
    var pantsMat = new THREE.MeshStandardMaterial({color:0x2b241f, roughness:0.7});
    var hairMat = new THREE.MeshStandardMaterial({color:0x241812, roughness:0.6});

    // ноги (скрыты стойкой, но добавляют объём)
    var legs = new THREE.Mesh(new THREE.CylinderGeometry(0.11,0.1,0.75,10), pantsMat);
    legs.position.y = 0.375;
    g.add(legs);

    // торс
    var torso = new THREE.Mesh(new THREE.CylinderGeometry(0.15,0.13,0.55,12), shirtMat);
    torso.position.y = 0.75+0.275;
    torso.castShadow = true;
    g.add(torso);

    // фартук
    var apron = new THREE.Mesh(new THREE.BoxGeometry(0.24,0.42,0.04), apronMat);
    apron.position.set(0, 0.75+0.2, 0.13);
    g.add(apron);
    var apronStrap = new THREE.Mesh(new THREE.TorusGeometry(0.16,0.012,6,16,Math.PI), apronMat);
    apronStrap.position.set(0, 1.02, 0);
    apronStrap.rotation.x = Math.PI/2;
    g.add(apronStrap);

    // плечи/руки
    var armGeo = new THREE.CylinderGeometry(0.045,0.04,0.42,8);
    var armL = new THREE.Mesh(armGeo, shirtMat);
    armL.position.set(-0.19, 0.75+0.18, 0.04);
    armL.rotation.z = 0.35;
    armL.rotation.x = -0.25;
    g.add(armL);
    var armR = new THREE.Mesh(armGeo, shirtMat);
    armR.position.set(0.19, 0.75+0.18, 0.04);
    armR.rotation.z = -0.35;
    armR.rotation.x = -0.25;
    g.add(armR);
    // кисти
    var handL = new THREE.Mesh(new THREE.SphereGeometry(0.045,8,8), skinMat);
    handL.position.set(-0.28, 0.75+0.02, 0.2);
    g.add(handL);
    var handR = new THREE.Mesh(new THREE.SphereGeometry(0.045,8,8), skinMat);
    handR.position.set(0.28, 0.75+0.02, 0.2);
    g.add(handR);

    // шея + голова
    var neck = new THREE.Mesh(new THREE.CylinderGeometry(0.045,0.05,0.07,8), skinMat);
    neck.position.y = 0.75+0.55+0.03;
    g.add(neck);
    var head = new THREE.Mesh(new THREE.SphereGeometry(0.12,16,16), skinMat);
    head.position.y = 0.75+0.55+0.15;
    head.castShadow = true;
    g.add(head);
    // причёска
    var hair = new THREE.Mesh(new THREE.SphereGeometry(0.125,16,16,0,Math.PI*2,0,Math.PI*0.55), hairMat);
    hair.position.y = 0.75+0.55+0.17;
    g.add(hair);

    // бариста-кепка (опционально стильно)
    var cap = new THREE.Mesh(new THREE.CylinderGeometry(0.1,0.11,0.06,16), apronMat);
    cap.position.y = 0.75+0.55+0.24;
    g.add(cap);

    g.position.set(x,0,z);
    g.rotation.y = rotY||0;
    return g;
  }
  // бариста работают в проходе между задней и клиентской стойками,
  // лицом к посетителям (в сторону входа, +Z)
  room.add(buildBarista(-0.9, baristaZ, 0));
  room.add(buildBarista(0.6, baristaZ, -0.15));

  // напольные светильники-споты (акцент у стойки)
  var spot = new THREE.SpotLight(0xffe3b0, 0.6, 6, Math.PI/6, 0.4);
  spot.position.set(0, WALL_HEIGHT-0.1, backCounterZ+0.6);
  spot.target.position.set(0, 1, backCounterZ);
  spot.castShadow = true;
  room.add(spot); room.add(spot.target);

  // ---------- освещение сцены ----------
  var ambient = new THREE.AmbientLight(0xfff1de, 0.55);
  scene.add(ambient);
  var dirLight = new THREE.DirectionalLight(0xfff4e0, 0.5);
  dirLight.position.set(3,6,4);
  dirLight.castShadow = true;
  dirLight.shadow.mapSize.set(1024,1024);
  scene.add(dirLight);
  var fillLight = new THREE.DirectionalLight(0x99b7d9, 0.15);
  fillLight.position.set(-4,3,-6);
  scene.add(fillLight);

  // мягкий свет "из холла" со стороны входа
  var entranceLight = new THREE.PointLight(0xcfe0f2, 0.4, 8, 2);
  entranceLight.position.set(0, 2, frontZ+1.5);
  scene.add(entranceLight);

  // ---------- анимация ----------
  var clock = new THREE.Clock();
  function animate(){
    requestAnimationFrame(animate);
    var t = clock.getElapsedTime();
    pendants.forEach(function(p,i){
      var flick = 1 + Math.sin(t*2+i)*0.02;
      if(p.userData.light) p.userData.light.intensity = p.userData.light.userData_on!==false ? p.userData.baseIntensity * flick : 0;
    });
    if(autoRotate){
      spherical.theta += 0.0025;
      updateCameraFromSpherical();
    }
    renderer.render(scene, camera);
  }

  // сохраним базовую интенсивность для мерцания
  pendants.forEach(function(p){
    p.userData.baseIntensity = p.userData.light.intensity;
  });

  // ---------- UI кнопки ----------
  function clearActive(){
    document.querySelectorAll('#controls-panel button').forEach(function(b){b.classList.remove('active');});
  }
  function setOrbitButtonActive(){
    clearActive();
    document.getElementById('btn-orbit').classList.add('active');
  }
  document.getElementById('btn-orbit').addEventListener('click', function(){
    setOrbitButtonActive();
  });
  document.getElementById('btn-front').addEventListener('click', function(){
    clearActive(); this.classList.add('active');
    spherical.theta = 0; spherical.phi = Math.PI*0.42; spherical.radius = 4.5;
    target.set(0,1.3,counterZ); updateCameraFromSpherical();
  });
  document.getElementById('btn-top').addEventListener('click', function(){
    clearActive(); this.classList.add('active');
    spherical.theta = 0.001; spherical.phi = 0.2; spherical.radius = 5.5;
    target.set(0,0,0); updateCameraFromSpherical();
  });
  document.getElementById('btn-side').addEventListener('click', function(){
    clearActive(); this.classList.add('active');
    spherical.theta = Math.PI/2; spherical.phi = Math.PI*0.4; spherical.radius = 4.5;
    target.set(0,1.2,0); updateCameraFromSpherical();
  });
  var autoBtn = document.getElementById('btn-auto');
  autoBtn.addEventListener('click', function(){
    autoRotate = !autoRotate;
    autoBtn.classList.toggle('active', autoRotate);
  });
  var timeBtn = document.getElementById('btn-time');
  var isEvening = false;
  timeBtn.addEventListener('click', function(){
    isEvening = !isEvening;
    timeBtn.textContent = isEvening ? 'День' : 'Вечер';
    timeBtn.classList.toggle('active', isEvening);
    if(isEvening){
      scene.background = new THREE.Color(0x0b0805);
      scene.fog.color = new THREE.Color(0x0b0805);
      ambient.intensity = 0.18;
      dirLight.intensity = 0.06;
      entranceLight.intensity = 0.15;
      pendants.forEach(function(p){ p.userData.baseIntensity = 1.3; });
    } else {
      scene.background = new THREE.Color(0x1c130d);
      scene.fog.color = new THREE.Color(0x1c130d);
      ambient.intensity = 0.55;
      dirLight.intensity = 0.5;
      entranceLight.intensity = 0.4;
      pendants.forEach(function(p){ p.userData.baseIntensity = 0.9; });
    }
  });

  document.getElementById('loading').style.opacity = 0;
  setTimeout(function(){ document.getElementById('loading').style.display='none'; }, 650);

  animate();

})();
</script>
</body>
</html>
