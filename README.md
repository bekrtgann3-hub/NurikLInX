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
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
      font-size: 1.8rem;
      margin-bottom: 5px;
      color: #fff;
      text-shadow: 0 0 10px rgba(139, 92, 246, 0.5);
    }

    .budget-card {
      background: linear-gradient(135deg, #1e1b4b, #311042);
      border: 1px solid var(--accent);
      border-radius: 12px;
      padding: 15px;
      text-align: center;
      margin-bottom: 20px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.3);
    }

    .budget-card h2 {
      font-size: 1.1rem;
      color: var(--text-muted);
    }

    .budget-card .price {
      font-size: 2rem;
      font-weight: bold;
      color: var(--green);
      margin-top: 5px;
    }

    .step {
      background-color: var(--card-bg);
      border: 1px solid var(--border);
      border-radius: 10px;
      padding: 15px;
      margin-bottom: 15px;
    }

    .step-title {
      font-size: 1.1rem;
      font-weight: bold;
      margin-bottom: 12px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .options-grid {
      display: grid;
      gap: 10px;
    }

    .option-card {
      background-color: #0f172a;
      border: 2px solid var(--border);
      border-radius: 8px;
      padding: 12px;
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

    .option-info {
      display: flex;
      flex-direction: column;
    }

    .option-name {
      font-weight: bold;
      font-size: 0.95rem;
    }

    .option-socket {
      font-size: 0.75rem;
      color: var(--text-muted);
    }

    .option-price {
      font-weight: bold;
      color: var(--accent);
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
      margin-top: 20px;
      transition: background 0.2s;
    }

    .btn:hover {
      background-color: var(--accent-hover);
    }

    /* Модальное окно результатов */
    .modal {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
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
      max-width: 500px;
      padding: 25px;
      box-shadow: 0 0 30px rgba(139, 92, 246, 0.4);
    }

    .modal-title {
      font-size: 1.5rem;
      text-align: center;
      margin-bottom: 20px;
    }

    .stat-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 12px;
      font-size: 1.1rem;
    }

    .stat-value {
      font-weight: bold;
    }

    .overbudget {
      color: var(--red) !important;
    }

    .compatibility-badge {
      padding: 4px 8px;
      border-radius: 5px;
      font-size: 0.9rem;
    }

    .comp-ok {
      background-color: rgba(16, 185, 129, 0.2);
      color: var(--green);
    }

    .comp-fail {
      background-color: rgba(239, 68, 68, 0.2);
      color: var(--red);
    }
  </style>
</head>
<body>

<div class="container">
  <header>
    <h1>⚡ Собери ПК за 5 минут</h1>
    <p style="color: var(--text-muted); font-size: 0.9rem;">Бюджет ограничен! Собери баланс.</p>
  </header>

  <div class="budget-card">
    <h2>ВАШ ОСТАТОК БЮДЖЕТА:</h2>
    <div class="price" id="budget-display">500 000 ₸</div>
  </div>

  <form id="pc-form">
    <!-- CPU -->
    <div class="step">
      <div class="step-title">1. Процессор (CPU)</div>
      <div class="options-grid" id="cpu-options"></div>
    </div>

    <!-- GPU -->
    <div class="step">
      <div class="step-title">2. Видеокарта (GPU)</div>
      <div class="options-grid" id="gpu-options"></div>
    </div>

    <!-- RAM -->
    <div class="step">
      <div class="step-title">3. Оперативная память (RAM)</div>
      <div class="options-grid" id="ram-options"></div>
    </div>

    <!-- SSD -->
    <div class="step">
      <div class="step-title">4. Накопитель (SSD)</div>
      <div class="options-grid" id="ssd-options"></div>
    </div>

    <!-- PSU -->
    <div class="step">
      <div class="step-title">5. Блок питания (PSU)</div>
      <div class="options-grid" id="psu-options"></div>
    </div>

    <button type="button" class="btn" onclick="calculateResult()">Завершить сборку 🔥</button>
  </form>
</div>

<!-- Результаты -->
<div class="modal" id="result-modal">
  <div class="modal-content">
    <div class="modal-title">Результат Сборки 🎮</div>
    
    <div class="stat-row">
      <span>💰 Итоговая цена:</span>
      <span class="stat-value" id="res-price">0 ₸</span>
    </div>
    
    <div class="stat-row">
      <span>🎮 Gaming:</span>
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

    <div id="compat-warning" style="color: var(--red); font-size: 0.85rem; margin-top: 5px; text-align: right;"></div>

    <button class="btn" onclick="closeModal()">Пересобрать 🔄</button>
  </div>
</div>

<script>
  const MAX_BUDGET = 500000;

  // База данных комплектующих
  const components = {
    cpu: [
      { id: 'cpu1', name: 'Intel Core i3-12100F', price: 45000, perf: 4, socket: 'LGA1700', power: 65 },
      { id: 'cpu2', name: 'AMD Ryzen 5 5600', price: 65000, perf: 6, socket: 'AM4', power: 65 },
      { id: 'cpu3', name: 'Intel Core i5-13400F', price: 110000, perf: 8, socket: 'LGA1700', power: 120 },
      { id: 'cpu4', name: 'AMD Ryzen 7 7800X3D', price: 210000, perf: 10, socket: 'AM5', power: 120 }
    ],
    gpu: [
      { id: 'gpu1', name: 'NVIDIA GTX 1650 4GB', price: 75000, gaming: 3, powerReq: 300 },
      { id: 'gpu2', name: 'NVIDIA RTX 3060 12GB', price: 160000, gaming: 6, powerReq: 550 },
      { id: 'gpu3', name: 'NVIDIA RTX 4060 Ti 8GB', price: 230000, gaming: 8, powerReq: 600 },
      { id: 'gpu4', name: 'NVIDIA RTX 4070 Super 12GB', price: 340000, gaming: 10, powerReq: 700 }
    ],
    ram: [
      { id: 'ram1', name: '8 GB DDR4 (1x8)', price: 12000, perf: 3 },
      { id: 'ram2', name: '16 GB DDR4 (2x8)', price: 22000, perf: 6 },
      { id: 'ram3', name: '32 GB DDR5 (2x16)', price: 55000, perf: 10 }
    ],
    ssd: [
      { id: 'ssd1', name: '480 GB SATA SSD', price: 18000, perf: 4 },
      { id: 'ssd2', name: '1 TB M.2 NVMe', price: 35000, perf: 8 },
      { id: 'ssd3', name: '2 TB High-Speed NVMe', price: 70000, perf: 10 }
    ],
    psu: [
      { id: 'psu1', name: '450W Standard', price: 18000, watts: 450 },
      { id: 'psu2', name: '600W 80+ Bronze', price: 28000, watts: 600 },
      { id: 'psu3', name: '750W 80+ Gold', price: 50000, watts: 750 }
    ]
  };

  const selected = {
    cpu: null,
    gpu: null,
    ram: null,
    ssd: null,
    psu: null
  };

  // Генерация UI вариантов
  function renderCategory(catKey, containerId) {
    const container = document.getElementById(containerId);
    container.innerHTML = components[catKey].map(item => `
      <div class="option-card" onclick="selectComponent('${catKey}', '${item.id}')" id="card-${item.id}">
        <div class="option-info">
          <span class="option-name">${item.name}</span>
        </div>
        <div class="option-price">${item.price.toLocaleString()} ₸</div>
      </div>
    `).join('');
  }

  function init() {
    renderCategory('cpu', 'cpu-options');
    renderCategory('gpu', 'gpu-options');
    renderCategory('ram', 'ram-options');
    renderCategory('ssd', 'ssd-options');
    renderCategory('psu', 'psu-options');
  }

  function selectComponent(category, id) {
    const item = components[category].find(x => x.id === id);
    selected[category] = item;

    // Сброс и подсветка активных карточек
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
    // Проверка, что выбраны все элементы
    if (!selected.cpu || !selected.gpu || !selected.ram || !selected.ssd || !selected.psu) {
      alert('Пожалуйста, выберите по одному компоненту из каждой категории!');
      return;
    }

    let totalPrice = selected.cpu.price + selected.gpu.price + selected.ram.price + selected.ssd.price + selected.psu.price;
    let gamingScore = selected.gpu.gaming;
    let perfScore = Math.round((selected.cpu.perf + selected.ram.perf + selected.ssd.perf) / 3);

    // Расчет совместимости
    let compatScore = 10;
    let compatWarning = "";

    // Хватает ли питания БП?
    if (selected.psu.watts < selected.gpu.powerReq) {
      compatScore -= 5;
      compatWarning = "⚠️ Блок питания слишком слабый для этой видеокарты!";
    }

    // Выход за бюджет
    if (totalPrice > MAX_BUDGET) {
      compatScore -= 3;
      if (compatWarning) compatWarning += " Превышен бюджет!";
      else compatWarning = "⚠️ Превышен лимит бюджета!";
    }

    // Вывод в модалку
    const priceElem = document.getElementById('res-price');
    priceElem.innerText = `${totalPrice.toLocaleString()} ₸`;
    if (totalPrice > MAX_BUDGET) {
      priceElem.classList.add('overbudget');
    } else {
      priceElem.classList.remove('overbudget');
    }

    document.getElementById('res-gaming').innerText = `${gamingScore}/10`;
    document.getElementById('res-perf').innerText = `${perfScore}/10`;
    
    const compatElem = document.getElementById('res-compat');
    compatElem.innerText = `${compatScore}/10`;
    compatElem.className = `stat-value compatibility-badge ${compatScore >= 8 ? 'comp-ok' : 'comp-fail'}`;

    document.getElementById('compat-warning').innerText = compatWarning;

    document.getElementById('result-modal').style.display = 'flex';
  }

  function closeModal() {
    document.getElementById('result-modal').style.display = 'none';
  }

  init();
</script>

</body>
</html>
