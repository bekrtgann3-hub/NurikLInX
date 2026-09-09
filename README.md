<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photo-Realistic 2D PC Simulator ($4,500 Budget)</title>
    <style>
        :root {
            --bg-color: #090d16;
            --panel-bg: rgba(15, 23, 42, 0.95);
            --accent-color: #3b82f6;
            --accent-hover: #2563eb;
            --success-color: #10b981;
            --danger-color: #ef4444;
            --text-main: #f8fafc;
            --text-sub: #94a3b8;
            --border-color: #334155;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            user-select: none;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-main);
            width: 100vw;
            height: 100vh;
            overflow: hidden;
            display: flex;
        }

        /* --- ЛЕВАЯ ЧАСТЬ: Визуализатор корпуса ПК --- */
        .viewport {
            flex: 1;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            background: radial-gradient(circle at center, #1e293b 0%, #090d16 100%);
            padding: 20px;
        }

        .pc-case-container {
            position: relative;
            width: 550px;
            height: 650px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Слои фотографий с прозрачностью */
        .pc-layer {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: contain;
            pointer-events: none;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            opacity: 0;
            transform: scale(0.95);
        }

        .pc-layer.active {
            opacity: 1;
            transform: scale(1);
        }

        /* Эффект свечения при включении */
        .rgb-glow {
            position: absolute;
            width: 320px;
            height: 380px;
            background: radial-gradient(circle, rgba(59, 130, 246, 0.5) 0%, rgba(0,0,0,0) 70%);
            border-radius: 50%;
            opacity: 0;
            transition: opacity 0.8s ease, background 0.5s ease;
            pointer-events: none;
            z-index: 1;
        }

        /* --- ПРАВАЯ ЧАСТЬ: Панель управления --- */
        .sidebar {
            width: 440px;
            background: var(--panel-bg);
            border-left: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 25px;
            box-shadow: -10px 0 30px rgba(0,0,0,0.5);
            z-index: 10;
        }

        .header h1 {
            font-size: 1.25rem;
            margin-bottom: 6px;
        }

        .header p {
            color: var(--text-sub);
            font-size: 0.85rem;
        }

        .budget-card {
            margin-top: 15px;
            background: rgba(0, 0, 0, 0.3);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 12px 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .budget-value {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--success-color);
        }

        .step-info {
            margin: 20px 0 10px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .step-title {
            font-size: 1rem;
            font-weight: 600;
            color: var(--accent-color);
        }

        .options-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            overflow-y: auto;
            max-height: calc(100vh - 340px);
            padding-right: 5px;
        }

        .options-list::-webkit-scrollbar {
            width: 4px;
        }
        .options-list::-webkit-scrollbar-thumb {
            background: var(--border-color);
            border-radius: 4px;
        }

        .card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 14px;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card:hover {
            background: rgba(255, 255, 255, 0.08);
            border-color: var(--accent-color);
        }

        .card.selected {
            border-color: var(--accent-color);
            background: rgba(59, 130, 246, 0.15);
            box-shadow: 0 0 12px rgba(59, 130, 246, 0.2);
        }

        .card-name {
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 2px;
        }

        .card-spec {
            font-size: 0.75rem;
            color: var(--text-sub);
        }

        .card-price {
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--success-color);
        }

        .footer {
            border-top: 1px solid var(--border-color);
            padding-top: 15px;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-weight: 700;
            background: var(--accent-color);
            color: white;
            cursor: pointer;
            transition: background 0.2s;
        }

        .btn:hover {
            background: var(--accent-hover);
        }

        .btn:disabled {
            background: #334155;
            color: #64748b;
            cursor: not-allowed;
        }

        .btn-power {
            background: var(--success-color);
            box-shadow: 0 0 20px rgba(16, 185, 129, 0.4);
        }
    </style>
</head>
<body>

    <!-- Слева: Изображение ПК -->
    <div class="viewport">
        <div class="pc-case-container">
            <!-- Эффект RGB Подсветки -->
            <div id="rgbGlow" class="rgb-glow"></div>

            <!-- Базовый пустой корпус (Слой 0) -->
            <img src="https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=800" class="pc-layer active" style="z-index: 2;" alt="Case">

            <!-- Накладываемые слои деталей (PNG) -->
            <img id="layer-mb" class="pc-layer" style="z-index: 3;" alt="Motherboard">
            <img id="layer-cpu" class="pc-layer" style="z-index: 4;" alt="CPU">
            <img id="layer-cooler" class="pc-layer" style="z-index: 5;" alt="Cooler">
            <img id="layer-ram" class="pc-layer" style="z-index: 6;" alt="RAM">
            <img id="layer-gpu" class="pc-layer" style="z-index: 7;" alt="GPU">
            <img id="layer-psu" class="pc-layer" style="z-index: 8;" alt="PSU">
        </div>
    </div>

    <!-- Справа: Панель выбора -->
    <div class="sidebar">
        <div>
            <div class="header">
                <h1>📸 Фото-Симулятор ПК</h1>
                <p>Бюджет: $4,500 • Реальные детали</p>
            </div>

            <div class="budget-card">
                <span>Остаток бюджета:</span>
                <span id="budgetRem" class="budget-value">$4,500</span>
            </div>

            <div class="step-info">
                <span class="step-title" id="stepTitle">Материнская плата</span>
                <span style="font-size: 0.8rem; color: var(--text-sub);" id="stepProgress">Шаг 1 из 6</span>
            </div>

            <div class="options-list" id="optionsList"></div>
        </div>

        <div class="footer">
            <div class="total-row">
                <span>Итого израсходовано:</span>
                <span id="totalPrice" style="color: var(--success-color);">$0</span>
            </div>
            <button class="btn" id="nextBtn" disabled onclick="nextStep()">Далее ➔</button>
        </div>
    </div>

    <script>
        const INITIAL_BUDGET = 4500;

        // Данные комплектующих с реальными фотографиями (PNG)
        const steps = [
            {
                title: "Материнская плата",
                layerId: "layer-mb",
                options: [
                    { name: "MSI MAG B760 TOMAHAWK", spec: "DDR5 / PCIe 5.0", price: 210, img: "https://pngimg.com/uploads/motherboard/motherboard_PNG30.png" },
                    { name: "ASUS ROG STRIX Z790-E", spec: "Wi-Fi 6E / Топ разгон", price: 450, img: "https://pngimg.com/uploads/motherboard/motherboard_PNG28.png" },
                    { name: "ASRock X670E Taichi Carrara", spec: "E-ATX Флагман", price: 580, img: "https://pngimg.com/uploads/motherboard/motherboard_PNG26.png" }
                ]
            },
            {
                title: "Процессор (CPU)",
                layerId: "layer-cpu",
                options: [
                    { name: "Intel Core i5-14600KF", spec: "14 ядер / 5.3 GHz", price: 300, img: "https://pngimg.com/uploads/cpu/cpu_PNG30.png" },
                    { name: "AMD Ryzen 9 7950X3D", spec: "16 ядер / Игровой лидер", price: 650, img: "https://pngimg.com/uploads/cpu/cpu_PNG25.png" },
                    { name: "Intel Core i9-14900KS", spec: "24 ядра / 6.2 GHz", price: 730, img: "https://pngimg.com/uploads/cpu/cpu_PNG12.png" }
                ]
            },
            {
                title: "Кулер для процессора",
                layerId: "layer-cooler",
                options: [
                    { name: "DeepCool AK620 Digital", spec: "Двухбашенный кулер", price: 90, img: "https://pngimg.com/uploads/cooler/cooler_PNG18.png" },
                    { name: "be quiet! Dark Rock Pro 5", spec: "Тихое мощное охлаждение", price: 130, img: "https://pngimg.com/uploads/cooler/cooler_PNG14.png" },
                    { name: "LIAN LI GA II 360 LCD", spec: "СВО с дисплеем", price: 280, img: "https://pngimg.com/uploads/cooler/cooler_PNG8.png" }
                ]
            },
            {
                title: "Оперативная память (RAM)",
                layerId: "layer-ram",
                options: [
                    { name: "Kingston Fury Beast 32GB", spec: "DDR5 6000MHz", price: 140, img: "https://pngimg.com/uploads/ram/ram_PNG21.png" },
                    { name: "Corsair Dominator Platinum 64GB", spec: "DDR5 7200MHz RGB", price: 340, img: "https://pngimg.com/uploads/ram/ram_PNG16.png" },
                    { name: "G.Skill Trident Z5 128GB", spec: "DDR5 6400MHz Extreme", price: 580, img: "https://pngimg.com/uploads/ram/ram_PNG12.png" }
                ]
            },
            {
                title: "Видеокарта (GPU)",
                layerId: "layer-gpu",
                options: [
                    { name: "NVIDIA RTX 4070 Ti SUPER 16GB", spec: "Мощный 1440p / 4K", price: 850, img: "https://pngimg.com/uploads/gpu/gpu_PNG10.png" },
                    { name: "AMD Radeon RX 7900 XTX 24GB", spec: "Флагман от AMD", price: 999, img: "https://pngimg.com/uploads/gpu/gpu_PNG9.png" },
                    { name: "NVIDIA RTX 4090 24GB OG", spec: "Абсолютный флагман", price: 2050, img: "https://pngimg.com/uploads/gpu/gpu_PNG27.png" }
                ]
            },
            {
                title: "Блок питания (PSU)",
                layerId: "layer-psu",
                options: [
                    { name: "be quiet! Pure Power 12 M 850W", spec: "80 PLUS Gold ATX 3.0", price: 140, img: "https://pngimg.com/uploads/psu/psu_PNG20.png" },
                    { name: "Corsair RM1000x 1000W", spec: "Модульный Gold", price: 210, img: "https://pngimg.com/uploads/psu/psu_PNG15.png" },
                    { name: "ASUS ROG Thor 1200W Platinum", spec: "OLED-дисплей / Platinum", price: 390, img: "https://pngimg.com/uploads/psu/psu_PNG8.png" }
                ]
            }
        ];

        let currentStep = 0;
        let selectedConfig = [];

        function renderStep() {
            const step = steps[currentStep];
            document.getElementById('stepTitle').innerText = step.title;
            document.getElementById('stepProgress').innerText = `Шаг ${currentStep + 1} из ${steps.length}`;

            const list = document.getElementById('optionsList');
            list.innerHTML = '';

            const currentTotal = selectedConfig.reduce((sum, item) => sum + (item ? item.price : 0), 0);

            step.options.forEach((opt) => {
                const card = document.createElement('div');
                card.className = 'card';

                const isOverBudget = (currentTotal + opt.price) > INITIAL_BUDGET;

                card.innerHTML = `
                    <div>
                        <div class="card-name">${opt.name}</div>
                        <div class="card-spec">${opt.spec}</div>
                    </div>
                    <div class="card-price" style="${isOverBudget ? 'color: var(--danger-color)' : ''}">$${opt.price}</div>
                `;

                if (!isOverBudget) {
                    card.onclick = () => selectOption(card, opt, step.layerId);
                } else {
                    card.style.opacity = '0.4';
                    card.style.cursor = 'not-allowed';
                }

                list.appendChild(card);
            });

            document.getElementById('nextBtn').disabled = true;
        }

        function selectOption(cardElement, option, layerId) {
            document.querySelectorAll('.card').forEach(c => c.classList.remove('selected'));
            cardElement.classList.add('selected');

            selectedConfig[currentStep] = option;
            updateSummary();

            // Обновление слоя изображения
            const layer = document.getElementById(layerId);
            layer.src = option.img;
            layer.classList.add('active');

            document.getElementById('nextBtn').disabled = false;
        }

        function updateSummary() {
            const total = selectedConfig.reduce((sum, item) => sum + (item ? item.price : 0), 0);
            const remaining = INITIAL_BUDGET - total;

            document.getElementById('totalPrice').innerText = `$${total}`;
            document.getElementById('budgetRem').innerText = `$${remaining}`;
        }

        function nextStep() {
            currentStep++;
            if (currentStep < steps.length) {
                renderStep();
            } else {
                showFinal();
            }
        }

        function showFinal() {
            document.getElementById('stepTitle').innerText = "Сборка завершена!";
            document.getElementById('stepProgress').innerText = "Успех";
            document.getElementById('optionsList').innerHTML = `
                <div style="color: var(--text-sub); font-size: 0.9rem; line-height: 1.6; padding: 10px 0;">
                    🎉 Поздравляем! Компьютер успешно собран из реальных комплектующих и уложен в $4,500.<br><br>
                    Нажмите кнопку ниже, чтобы подать питание и включить систему!
                </div>
            `;

            const btn = document.getElementById('nextBtn');
            btn.innerText = "⚡ Запустить ПК";
            btn.className = "btn btn-power";
            btn.disabled = false;
            btn.onclick = powerOn;
        }

        function powerOn() {
            const glow = document.getElementById('rgbGlow');
            glow.style.opacity = '1';

            let hue = 0;
            setInterval(() => {
                hue = (hue + 2) % 360;
                glow.style.background = `radial-gradient(circle, hsla(${hue}, 100%, 50%, 0.6) 0%, rgba(0,0,0,0) 75%)`;
            }, 30);
        }

        renderStep();
    </script>
</body>
</html>
