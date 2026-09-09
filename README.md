<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Собери ПК за 5 минут 🔥</title>
  <style>
    :root {
      --bg: #0f172a;
      --card-bg: #1e293b;
      --accent: #8b5cf6;
      --accent-hover: #7c3aed;
      --text: #f8fafc;
      --text-muted: #94a3b8;
      --border: #334155;
      --green: #10b981;
      --red: #ef4444;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Roboto, sans-serif;
    }

    body {
      background-color: var(--bg);
      color: var(--text);
      padding: 15px;
      display: flex;
      justify-content: center;
    }

    .container {
      max-width: 600px;
      width: 100%;
      padding-bottom: 30px;
    }

    header {
      text-align: center;
      margin-bottom: 20px;
    }

    h1 {
      font-size: 1.7rem;
      margin-bottom: 5px;
      text-shadow: 0 0 10px rgba(139, 92, 246, 0.5);
    }

    .budget-card {
      position: sticky;
      top: 10px;
      z-index: 100;
      background: rgba(30, 27, 75, 0.95);
      backdrop-filter: blur(8px);
      border: 1px solid var(--accent);
      border-radius: 12px;
      padding: 12px;
      text-align: center;
      margin-bottom: 20px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.5);
    }

    .budget-card h2 {
      font-size: 0.9rem;
      color: var(--text-muted);
    }

    .budget-card .price {
      font-size: 1.8rem;
      font-weight: bold;
      color: var(--green);
      margin-top: 2px;
    }

    .step {
      background-color: var(--card-bg);
      border: 1px solid var(--border);
      border-radius: 10px;
      padding: 15px;
      margin-bottom: 15px;
    }

    .step-title {
      font-size: 1.05rem;
      font-weight: bold;
      margin-bottom: 12px;
      color: #e2e8f0;
    }

    .options-grid {
      display: grid;
      gap: 8px;
    }

    .option-card {
      background-color: #0f172a;
      border: 2px solid var(--border);
      border-radius: 8px;
      padding: 10px 12px;
      cursor: pointer;
      transition: all 0.2s ease;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .option-card:hover {
      border-color: var(--accent);
    }

    .option-card.selected {
      border-color: var(--accent);
      background-color: rgba(139, 92, 246, 0.15);
      box-shadow: 0 0 10px rgba(139, 92, 246, 0.3);
    }

    .option-name {
      font-weight: 600;
      font-size: 0.9rem;
    }

    .option-price {
      font-weight: bold;
      color: var(--accent);
      font-size: 0.95rem;
    }

    .btn {
      width: 100%;
      background-color: var(--accent);
      color: white;
      border: none;
      padding: 15px;
      border-radius: 10px;
      font-size: 1.1rem;
      font-weight: bold;
      cursor: pointer;
      margin-top: 15px;
      transition: background 0.2s;
    }

    .btn:hover {
      background-color: var(--accent-hover);
    }

    /* Модалка */
    .modal {
      display: none;
      position: fixed;
      top: 0; left: 0; width: 100%; height: 100%;
      background: rgba(0,0,0,0.85);
      backdrop-filter: blur(5px);
      justify-content: center;
      align-items: center;
      padding: 15px;
      z-index: 1000;
    }

    .modal-content {
      background-color: var(--card-bg);
      border: 1px solid var(--accent);
      border-radius: 15px;
      width: 100%;
      max-width: 480px;
      padding: 20px;
      box-shadow: 0 0 30px rgba(139, 92, 246, 0.4);
    }

    .modal-title {
      font-size: 1.4rem;
      text-align: center;
      margin-bottom: 15px;
    }

    .stat-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
      font-size: 1rem;
    }

    .stat-value {
      font-weight: bold;
    }

    .overbudget {
      color: var(--red) !important;
    }

    .compatibility-badge {
      padding: 3px 8px;
      border-radius: 5px;
      font-size: 0.85rem;
    }

    .comp-ok { background-color: rgba(16, 185, 129, 0.2); color: var(--green); }
    .comp-fail { background-color: rgba(239, 68, 68, 0.2); color: var(--red); }
  </style>
</head>
<body>

<div class="container">
  <header>
    <h1>🎮 Собери ПК за 5 минут</h1>
    <p style="color: var(--text-muted); font-size: 0.85rem;">Бюджет: 500 000 ₸. Собери идеальный игровой ПК!</p>
  </header>

  <div class="budget-card">
    <h2>ОСТАТОК БЮДЖЕТА:</h2>
    <div class="price" id="budget-display">500 000 ₸</div>
  </div>

  <form id="pc-form">
    <!-- 8 Категорий -->
    <div class="step"><div class="step-title">1. Процессор (CPU)</div><div class="options-grid" id="cpu-options"></div></div>
    <div class="step"><div class="step-title">2. Охлаждение (Cooler)</div><div class="options-grid" id="cooler-options"></div></div>
    <div class="step"><div class="step-title">3. Материнская плата</div><div class="options-grid" id="mobo-options"></div></div>
    <div class="step"><div class="step-title">4. Видеокарта (GPU)</div><div class="options-grid" id="gpu-options"></div></div>
    <div class="step"><div class="step-title">5. Оперативная память (RAM)</div><div class="options-grid" id="ram-options"></div></div>
    <div class="step"><div class="step-title">6. Накопитель (SSD)</div><div class="options-grid" id="ssd-options"></div></div>
    <div class="step"><div class="step-title">7. Блок питания (PSU)</div><div class="options-grid" id="psu-options"></div></div>
    <div class="step"><div class="step-title">8. Корпус (Case)</div><div class="options-grid" id="case-options"></div></div>

    <button type="button" class="btn" onclick="calculateResult()">Завершить сборку 🔥</button>
  </form>
</div>

<!-- Модальное окно -->
<div class="modal" id="result-modal">
  <div class="modal-content">
    <div class="modal-title">Результаты сборки 🏆</div>
    
    <div class="stat-row">
      <span>💰 Итоговая цена:</span>
      <span class="stat-value" id="res-price">0 ₸</span>
    </div>
    
    <div class="stat-row">
      <span>🎮 Gaming Score:</span>
      <span class="stat-value" id="res-gaming" style="color: #3b82f6;">0/10</span>
    </div>
    
    <div class="stat-row">
      <span>⚡ Performance:</span>
      <span class="stat-value" id="res-perf" style="color: #eab308;">0/10</span>
    </div>
    
    <div class="stat-row">
      <span>⚠️ Совместимость:</span>
      <span id="res-compat">10/10</span>
    </div>

    <div id="compat-warning" style="color: var(--red); font-size: 0.8rem; margin-top: 8px; text-align: left; line-height: 1.3;"></div>

    <button class="btn" onclick="closeModal()">Пересобрать 🔄</button>
  </div>
</div>

<script>
  const MAX_BUDGET = 500000;

  // База данных с адекватными ценами (в ₸)
  const components = {
    cpu: [
      { id: 'cpu1', name: 'Intel Core i3-12100F', price: 42000, perf: 4, heat: 65 },
      { id: 'cpu2', name: 'AMD Ryzen 5 5600', price: 55000, perf: 6, heat: 65 },
      { id: 'cpu3', name: 'Intel Core i5-13400F', price: 95000, perf: 8, heat: 120 },
      { id: 'cpu4', name: 'AMD Ryzen 7 7800X3D', price: 185000, perf: 10, heat: 120 }
    ],
    cooler: [
      { id: 'col1', name: 'Боксовый кулер (Кусок алюминия)', price: 3000, tdp: 65 },
      { id: 'col2', name: 'Башня DeepCool AG400 (4 трубки)', price: 11000, tdp: 150 },
      { id: 'col3', name: 'Двухбашенный ID-Cooling SE-207', price: 24000, tdp: 220 },
      { id: 'col4', name: 'СВО (Водянка) 360mm ARGB', price: 48000, tdp: 300 }
    ],
    mobo: [
      { id: 'mb1', name: 'Базовая A520 / H610', price: 32000, perf: 4 },
      { id: 'mb2', name: 'Средний класс B550 / B760', price: 58000, perf: 7 },
      { id: 'mb3', name: 'Топовая Z790 / X670', price: 120000, perf: 10 }
    ],
    gpu: [
      { id: 'gpu1', name: 'NVIDIA GTX 1650 4GB', price: 68000, gaming: 3, powerReq: 350 },
      { id: 'gpu2', name: 'NVIDIA RTX 3060 12GB', price: 145000, gaming: 6, powerReq: 550 },
      { id: 'gpu3', name: 'NVIDIA RTX 4060 Ti 8GB', price: 215000, gaming: 8, powerReq: 600 },
      { id: 'gpu4', name: 'NVIDIA RTX 4070 Super 12GB', price: 330000, gaming: 10, powerReq: 700 }
    ],
    ram: [
      { id: 'ram1', name: '8 GB DDR4 (1x8)', price: 9000, perf: 3 },
      { id: 'ram2', name: '16 GB DDR4 (2x8)', price: 18000, perf: 6 },
      { id: 'ram3', name: '32 GB DDR5 (2x16) 6000MHz', price: 48000, perf: 10 }
    ],
    ssd: [
      { id: 'ssd1', name: '512 GB SATA SSD', price: 15000, perf: 4 },
      { id: 'ssd2', name: '1 TB M.2 NVMe (3500 MB/s)', price: 32000, perf: 8 },
      { id: 'ssd3', name: '2 TB High-Speed NVMe (7000 MB/s)', price: 62000, perf: 10 }
    ],
    psu: [
      { id: 'psu1', name: '450W Стандарт', price: 15000, watts: 450 },
      { id: 'psu2', name: '600W 80+ Bronze', price: 24000, watts: 600 },
      { id: 'psu3', name: '750W 80+ Gold', price: 42000, watts: 750 }
    ],
    case: [
      { id: 'cs1', name: 'Офисный глухой корпус', price: 10000, airflow: 3 },
      { id: 'cs2', name: 'Игровой Mesh с 4 вентиляторами', price: 22000, airflow: 8 },
      { id: 'cs3', name: 'Аквариум Premium RGB', price: 45000, airflow: 10 }
    ]
  };

  const selected = {
    cpu: null, cooler: null, mobo: null, gpu: null,
    ram: null, ssd: null, psu: null, case: null
  };

  function renderCategory(catKey, containerId) {
    const container = document.getElementById(containerId);
    container.innerHTML = components[catKey].map(item => `
      <div class="option-card" onclick="selectComponent('${catKey}', '${item.id}')" id="card-${item.id}">
        <span class="option-name">${item.name}</span>
        <span class="option-price">${item.price.toLocaleString()} ₸</span>
      </div>
    `).join('');
  }

  function init() {
    renderCategory('cpu', 'cpu-options');
    renderCategory('cooler', 'cooler-options');
    renderCategory('mobo', 'mobo-options');
    renderCategory('gpu', 'gpu-options');
    renderCategory('ram', 'ram-options');
    renderCategory('ssd', 'ssd-options');
    renderCategory('psu', 'psu-options');
    renderCategory('case', 'case-options');
  }

  function selectComponent(category, id) {
    const item = components[category].find(x => x.id === id);
    selected[category] = item;

    components[category].forEach(x => {
      document.getElementById(`card-${x.id}`).classList.remove('selected');
    });
    document.getElementById(`card-${id}`).classList.add('selected');

    updateBudget();
  }

  function updateBudget() {
    let currentTotal = 0;
    Object.values(selected).forEach(item => {
      if (item) currentTotal += item.price;
    });

    const remaining = MAX_BUDGET - currentTotal;
    const budgetElem = document.getElementById('budget-display');
    budgetElem.innerText = `${remaining.toLocaleString()} ₸`;

    if (remaining < 0) {
      budgetElem.classList.add('overbudget');
    } else {
      budgetElem.classList.remove('overbudget');
    }
  }

  function calculateResult() {
    // Проверка выбора
    const categories = ['cpu', 'cooler', 'mobo', 'gpu', 'ram', 'ssd', 'psu', 'case'];
    for (let cat of categories) {
      if (!selected[cat]) {
        alert('Выбери все 8 компонентов!');
        return;
      }
    }

    let totalPrice = Object.values(selected).reduce((acc, item) => acc + item.price, 0);
    let gamingScore = selected.gpu.gaming;
    let perfScore = Math.round((selected.cpu.perf + selected.ram.perf + selected.ssd.perf + selected.mobo.perf) / 4);

    let compatScore = 10;
    let warnings = [];

    // Проверка 1: Хватает ли блока питания?
    if (selected.psu.watts < selected.gpu.powerReq) {
      compatScore -= 4;
      warnings.push("⚠️ Блок питания слишком слабый для этой видеокарты.");
    }

    // Проверка 2: Хватает ли кулера процессору?
    if (selected.cooler.tdp < selected.cpu.heat) {
      compatScore -= 3;
      warnings.push("⚠️ Кулер слабый: процессор будет перегреваться и троттлить!");
    }

    // Проверка 3: Превышение бюджета
    if (totalPrice > MAX_BUDGET) {
      compatScore -= 3;
      warnings.push("⚠️ Превышен лимит бюджета 500 000 ₸.");
    }

    if (compatScore < 0) compatScore = 0;

    // Вывод результатов
    const priceElem = document.getElementById('res-price');
    priceElem.innerText = `${totalPrice.toLocaleString()} ₸`;
    priceElem.className = `stat-value ${totalPrice > MAX_BUDGET ? 'overbudget' : ''}`;

    document.getElementById('res-gaming').innerText = `${gamingScore}/10`;
    document.getElementById('res-perf').innerText = `${perfScore}/10`;
    
    const compatElem = document.getElementById('res-compat');
    compatElem.innerText = `${compatScore}/10`;
    compatElem.className = `stat-value compatibility-badge ${compatScore >= 8 ? 'comp-ok' : 'comp-fail'}`;

    document.getElementById('compat-warning').innerHTML = warnings.join('<br>');
    document.getElementById('result-modal').style.display = 'flex';
  }

  function closeModal() {
    document.getElementById('result-modal').style.display = 'none';
  }

  init();
</script>

</body>
</html>
