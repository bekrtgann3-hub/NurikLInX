<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ultimate PC Building Simulator 3D ($4500 Budget)</title>
    <style>
        :root {
            --bg-color: #0b0f19;
            --panel-bg: rgba(15, 23, 42, 0.88);
            --accent-color: #3b82f6;
            --accent-hover: #2563eb;
            --success-color: #10b981;
            --danger-color: #ef4444;
            --text-main: #f8fafc;
            --text-sub: #cbd5e1;
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
            background: #090d16;
            color: var(--text-main);
            overflow: hidden;
            width: 100vw;
            height: 100vh;
        }

        #canvas-container {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            z-index: 1;
        }

        .ui-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 10;
            pointer-events: none;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 25px;
        }

        .header {
            background: var(--panel-bg);
            backdrop-filter: blur(16px);
            padding: 16px 24px;
            border-radius: 16px;
            border: 1px solid var(--border-color);
            pointer-events: auto;
            max-width: 440px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }

        .header h1 {
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header p {
            color: var(--text-sub);
            font-size: 0.85rem;
            margin-top: 4px;
        }

        .budget-bar {
            margin-top: 12px;
            background: rgba(0,0,0,0.4);
            border-radius: 10px;
            padding: 8px 12px;
            display: flex;
            justify-content: space-between;
            font-size: 0.9rem;
            border: 1px solid var(--border-color);
        }

        .budget-value {
            font-weight: bold;
            color: var(--success-color);
        }

        .sidebar {
            position: absolute;
            right: 25px;
            top: 25px;
            bottom: 25px;
            width: 420px;
            background: var(--panel-bg);
            backdrop-filter: blur(16px);
            border-radius: 20px;
            border: 1px solid var(--border-color);
            padding: 20px;
            pointer-events: auto;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            box-shadow: 0 20px 50px rgba(0,0,0,0.6);
        }

        .step-indicator {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: var(--accent-color);
            font-weight: 700;
            margin-bottom: 6px;
        }

        .step-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .options-grid {
            display: flex;
            flex-direction: column;
            gap: 10px;
            overflow-y: auto;
            max-height: calc(100vh - 290px);
            padding-right: 5px;
        }

        .options-grid::-webkit-scrollbar {
            width: 4px;
        }
        .options-grid::-webkit-scrollbar-thumb {
            background: var(--border-color);
            border-radius: 4px;
        }

        .option-card {
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 12px 16px;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .option-card:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: var(--accent-color);
        }

        .option-card.selected {
            border-color: var(--accent-color);
            background: rgba(59, 130, 246, 0.2);
            box-shadow: 0 0 15px rgba(59, 130, 246, 0.3);
        }

        .option-info {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .option-name {
            font-weight: 600;
            font-size: 0.9rem;
        }

        .option-spec {
            font-size: 0.75rem;
            color: var(--text-sub);
        }

        .option-price {
            font-weight: 700;
            color: var(--success-color);
            font-size: 0.95rem;
        }

        .price-summary {
            padding: 12px 0;
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .footer-controls {
            display: flex;
            gap: 10px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-next {
            background: var(--accent-color);
            color: white;
        }

        .btn-next:hover {
            background: var(--accent-hover);
        }

        .btn-next:disabled {
            background: #334155;
            color: #64748b;
            cursor: not-allowed;
        }

        .btn-power {
            background: var(--success-color);
            color: white;
            box-shadow: 0 0 20px rgba(16, 185, 129, 0.4);
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }

        .controls-hint {
            position: absolute;
            bottom: 25px;
            left: 25px;
            background: var(--panel-bg);
            backdrop-filter: blur(16px);
            padding: 10px 18px;
            border-radius: 30px;
            border: 1px solid var(--border-color);
            font-size: 0.8rem;
            color: var(--text-sub);
            pointer-events: auto;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/controls/OrbitControls.js"></script>
</head>
<body>

    <div id="canvas-container"></div>

    <div class="ui-overlay">
        <div class="header">
            <h1>🎮 Симулятор ПК ($4,500 Budget)</h1>
            <p>Собери кастомный ПК и уложись в имеющийся бюджет</p>
            <div class="budget-bar">
                <span>Остаток бюджета:</span>
                <span id="budgetRem" class="budget-value">$4,500</span>
            </div>
        </div>

        <div class="controls-hint">
            🖱️ ЛКМ — Вращение камеры | ПКМ — Зажать и двигать | Колесико — Зум
        </div>

        <div class="sidebar">
            <div>
                <div class="step-indicator" id="stepIndicator">Шаг 1 из 7</div>
                <div class="step-title" id="stepTitle">Загрузка...</div>
                <div class="options-grid" id="optionsGrid"></div>
            </div>

            <div>
                <div class="price-summary">
                    <span>Затрачено:</span>
                    <span id="totalPrice" style="color: var(--success-color); font-size: 1.1rem;">$0</span>
                </div>
                <div class="footer-controls">
                    <button class="btn btn-next" id="nextBtn" disabled onclick="nextStep()">Далее ➔</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        const INITIAL_BUDGET = 4500;
        let isSystemPoweredOn = false;
        const rotatingFans = [];

        // --- 1. Сцена и Рендерер ---
        const container = document.getElementById('canvas-container');
        const scene = new THREE.Scene();
        scene.fog = new THREE.FogExp2(0x090d16, 0.025);

        const camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 0.1, 1000);
        camera.position.set(3.5, 2.0, 4.2);

        const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(window.devicePixelRatio);
        renderer.shadowMap.enabled = true;
        renderer.shadowMap.type = THREE.PCFSoftShadowMap;
        container.appendChild(renderer.domElement);

        const controls = new THREE.OrbitControls(camera, renderer.domElement);
        controls.enableDamping = true;
        controls.dampingFactor = 0.05;
        controls.maxPolarAngle = Math.PI / 2 + 0.05; // Не падать ниже стола

        // --- Освещение ---
        const ambientLight = new THREE.AmbientLight(0xffffff, 0.7);
        scene.add(ambientLight);

        const mainLight = new THREE.DirectionalLight(0xffffff, 1.2);
        mainLight.position.set(5, 8, 5);
        mainLight.castShadow = true;
        scene.add(mainLight);

        const fillLight = new THREE.DirectionalLight(0x3b82f6, 0.6);
        fillLight.position.set(-5, 4, -5);
        scene.add(fillLight);

        const innerLight = new THREE.PointLight(0xffffff, 0.8, 4);
        innerLight.position.set(0, 0.2, 0.2);
        scene.add(innerLight);

        // Динамическая подсветка
        const caseLight = new THREE.PointLight(0x3b82f6, 0, 5);
        caseLight.position.set(0, 0, 0);
        scene.add(caseLight);

        // --- Стол и Окружение ---
        const tableGeo = new THREE.BoxGeometry(10, 0.2, 6);
        const tableMat = new THREE.MeshStandardMaterial({ color: 0x1e1b18, roughness: 0.6, metalness: 0.1 });
        const table = new THREE.Mesh(tableGeo, tableMat);
        table.position.set(0, -1.2, 0);
        table.receiveShadow = true;
        scene.add(table);

        // --- 2. Генератор Корпуса ---
        const caseGroup = new THREE.Group();
        scene.add(caseGroup);

        function createOpenCase() {
            const group = new THREE.Group();
            const darkMat = new THREE.MeshStandardMaterial({ color: 0x0f172a, roughness: 0.3, metalness: 0.8 });
            const accentMat = new THREE.MeshStandardMaterial({ color: 0x1e293b, roughness: 0.2 });

            // Задняя панель
            const backPanel = new THREE.Mesh(new THREE.BoxGeometry(0.06, 2.2, 2.0), darkMat);
            backPanel.position.set(-0.8, 0, 0);

            // Верх и Низ
            const topPanel = new THREE.Mesh(new THREE.BoxGeometry(1.6, 0.06, 2.0), darkMat);
            topPanel.position.set(0, 1.1, 0);

            const psuShroud = new THREE.Mesh(new THREE.BoxGeometry(1.6, 0.45, 2.0), accentMat);
            psuShroud.position.set(0, -0.88, 0);

            // Закаленное стекло
            const glassMat = new THREE.MeshPhysicalMaterial({
                color: 0xffffff,
                transparent: true,
                opacity: 0.15,
                roughness: 0.1,
                transmission: 0.9,
                thickness: 0.2
            });
            const glass = new THREE.Mesh(new THREE.BoxGeometry(1.6, 2.18, 0.02), glassMat);
            glass.position.set(0, 0, 1.0);

            group.add(backPanel, topPanel, psuShroud, glass);
            return group;
        }
        caseGroup.add(createOpenCase());

        const activeMeshes = {};

        // --- 3. Компоненты ПК ---
        const MeshBuilders = {
            mb: (type) => {
                const group = new THREE.Group();
                const pcbColor = type === 'white' ? 0xe2e8f0 : (type === 'taichi' ? 0x0f172a : 0x1e293b);
                const pcb = new THREE.Mesh(
                    new THREE.BoxGeometry(0.08, 1.8, 1.5),
                    new THREE.MeshStandardMaterial({ color: pcbColor, roughness: 0.3 })
                );

                const heatsinkColor = type === 'taichi' ? 0xd97706 : 0x475569;
                const heatsink = new THREE.Mesh(
                    new THREE.BoxGeometry(0.14, 0.55, 0.45),
                    new THREE.MeshStandardMaterial({ color: heatsinkColor, metalness: 0.9, roughness: 0.1 })
                );
                heatsink.position.set(0.03, 0.55, -0.45);

                group.add(pcb, heatsink);
                group.position.set(-0.7, 0, 0);
                return group;
            },

            cpu: (variant) => {
                const group = new THREE.Group();
                const capColor = variant.includes('AMD') ? 0xb45309 : 0x94a3b8;
                const cpu = new THREE.Mesh(
                    new THREE.BoxGeometry(0.04, 0.38, 0.38),
                    new THREE.MeshStandardMaterial({ color: capColor, metalness: 0.95, roughness: 0.1 })
                );
                group.add(cpu);
                group.position.set(-0.62, 0.3, 0);
                return group;
            },

            cooler: (type) => {
                const group = new THREE.Group();
                if (type === 'air_small') {
                    const rad = new THREE.Mesh(new THREE.BoxGeometry(0.25, 0.4, 0.4), new THREE.MeshStandardMaterial({ color: 0xcbd5e1, metalness: 0.8 }));
                    const fan = new THREE.Mesh(new THREE.CylinderGeometry(0.18, 0.18, 0.05), new THREE.MeshStandardMaterial({ color: 0x2563eb }));
                    fan.rotation.z = Math.PI / 2;
                    fan.position.x = 0.15;
                    group.add(rad, fan);
                    group.position.set(-0.45, 0.3, 0);
                    rotatingFans.push(fan);
                } else if (type === 'air_big') {
                    const rad1 = new THREE.Mesh(new THREE.BoxGeometry(0.2, 0.55, 0.5), new THREE.MeshStandardMaterial({ color: 0x334155, metalness: 0.8 }));
                    const rad2 = rad1.clone();
                    rad2.position.x = 0.2;
                    group.add(rad1, rad2);
                    group.position.set(-0.45, 0.3, 0);
                } else if (type === 'water') {
                    const pump = new THREE.Mesh(new THREE.CylinderGeometry(0.18, 0.18, 0.1), new THREE.MeshStandardMaterial({ color: 0x3b82f6, metalness: 0.8 }));
                    pump.rotation.z = Math.PI / 2;
                    pump.position.set(-0.58, 0.3, 0);
                    const rad = new THREE.Mesh(new THREE.BoxGeometry(1.4, 0.08, 0.45), new THREE.MeshStandardMaterial({ color: 0x0f172a }));
                    rad.position.set(0, 1.02, 0);
                    group.add(pump, rad);
                }
                return group;
            },

            ram: (count, isRGB) => {
                const group = new THREE.Group();
                const color = isRGB ? 0xec4899 : 0x334155;
                for(let i = 0; i < count; i++) {
                    const stick = new THREE.Mesh(
                        new THREE.BoxGeometry(0.04, 0.48, 0.06),
                        new THREE.MeshStandardMaterial({ color: color, metalness: 0.8 })
                    );
                    stick.position.set(0, 0, i * 0.08);
                    group.add(stick);
                }
                group.position.set(-0.62, 0.3, 0.2);
                return group;
            },

            ssd: (hasHeatsink) => {
                const group = new THREE.Group();
                const h = hasHeatsink ? 0.07 : 0.02;
                const mat = hasHeatsink 
                    ? new THREE.MeshStandardMaterial({ color: 0x2563eb, metalness: 0.9 }) 
                    : new THREE.MeshStandardMaterial({ color: 0x15803d });
                
                const ssd = new THREE.Mesh(new THREE.BoxGeometry(0.03, h, 0.38), mat);
                group.add(ssd);
                group.position.set(-0.62, -0.2, 0.2);
                return group;
            },

            gpu: (sizeCategory) => {
                const group = new THREE.Group();
                let length = 0.7, height = 0.25, width = 0.8, fanCount = 2;

                if (sizeCategory === 'large') { length = 0.85; width = 1.2; fanCount = 3; }
                else if (sizeCategory === 'extreme') { length = 1.0; height = 0.38; width = 1.45; fanCount = 3; }

                const body = new THREE.Mesh(
                    new THREE.BoxGeometry(length, height, width),
                    new THREE.MeshStandardMaterial({ color: 0x0f172a, metalness: 0.9, roughness: 0.2 })
                );
                group.add(body);

                const spacing = width / fanCount;
                for(let i = 0; i < fanCount; i++) {
                    const fan = new THREE.Mesh(
                        new THREE.CylinderGeometry(0.18, 0.18, 0.02),
                        new THREE.MeshStandardMaterial({ color: 0x475569 })
                    );
                    fan.position.set(0, -height/2 - 0.01, -width/2 + spacing/2 + i*spacing);
                    group.add(fan);
                    rotatingFans.push(fan);
                }

                group.position.set(-0.15, -0.3, 0);
                return group;
            },

            psu: (isModular) => {
                const group = new THREE.Group();
                const psu = new THREE.Mesh(
                    new THREE.BoxGeometry(0.7, 0.4, 0.9),
                    new THREE.MeshStandardMaterial({ color: isModular ? 0x1e293b : 0x334155, metalness: 0.8 })
                );
                group.add(psu);
                group.position.set(-0.35, -0.85, -0.3);
                return group;
            }
        };

        // --- 4. Список шагов с ценами для $4500 бюджета ---
        const steps = [
            {
                title: "Материнская плата",
                partKey: "mb",
                options: [
                    { name: "MSI MAG B760 TOMAHAWK", spec: "mATX / Базовый выбор", price: 210, type: "standard" },
                    { name: "ASUS ROG STRIX Z790-A Gaming", spec: "ATX / Премиум Светлая", price: 420, type: "white" },
                    { name: "ASRock X670E Taichi Carrara", spec: "E-ATX / Флагман под разгон", price: 580, type: "taichi" }
                ]
            },
            {
                title: "Процессор (CPU)",
                partKey: "cpu",
                options: [
                    { name: "Intel Core i5-14600KF", spec: "14 ядер / 5.3 ГГц", price: 300, variant: "Intel" },
                    { name: "AMD Ryzen 9 7950X3D", spec: "16 ядер / Игровой гигант", price: 650, variant: "AMD" },
                    { name: "Intel Core i9-14900KS", spec: "24 ядра / 6.2 ГГц Топ", price: 730, variant: "Intel" }
                ]
            },
            {
                title: "Система охлаждения",
                partKey: "cooler",
                options: [
                    { name: "DeepCool AK620 Digital", spec: "Воздушная башня с дисплеем", price: 90, type: "air_small" },
                    { name: "be quiet! Dark Rock Elite", spec: "Массивный двойной кулер", price: 120, type: "air_big" },
                    { name: "LIAN LI GA II LCD SL-INF 360", spec: "СВО 360mm с LCD-экраном", price: 280, type: "water" }
                ]
            },
            {
                title: "Оперативная память (RAM)",
                partKey: "ram",
                options: [
                    { name: "Kingston Fury Beast 32GB (2x16)", spec: "DDR5 6000MHz", price: 140, count: 2, isRGB: false },
                    { name: "Corsair Dominator Titanium 64GB", spec: "DDR5 7200MHz RGB (2x32)", price: 340, count: 2, isRGB: true },
                    { name: "G.Skill Trident Z5 RGB 128GB", spec: "DDR5 6400MHz (4x32GB)", price: 580, count: 4, isRGB: true }
                ]
            },
            {
                title: "Накопитель (SSD M.2)",
                partKey: "ssd",
                options: [
                    { name: "Samsung 980 PRO 1TB", spec: "PCIe 4.0 / 7000 MB/s", price: 100, hasHeatsink: false },
                    { name: "Samsung 990 PRO 2TB RGB", spec: "PCIe 4.0 с радиатором", price: 210, hasHeatsink: true },
                    { name: "Crucial T700 4TB NVMe Gen5", spec: "PCIe 5.0 / 12400 MB/s Extreme", price: 520, hasHeatsink: true }
                ]
            },
            {
                title: "Видеокарта (GPU)",
                partKey: "gpu",
                options: [
                    { name: "NVIDIA RTX 4070 Ti SUPER 16GB", spec: "Отлично для 1440p / 4K", price: 850, sizeCategory: "large" },
                    { name: "NVIDIA RTX 4080 SUPER 16GB", spec: "Ультимативный гейминг", price: 1100, sizeCategory: "large" },
                    { name: "NVIDIA RTX 4090 24GB OG OC", spec: "Абсолютный монстр 24GB", price: 2050, sizeCategory: "extreme" }
                ]
            },
            {
                title: "Блок питания (PSU)",
                partKey: "psu",
                options: [
                    { name: "be quiet! Pure Power 12 M 850W", spec: "Gold ATX 3.0", price: 140, isModular: true },
                    { name: "Corsair RM1000x Shift 1000W", spec: "Gold Боковое подключение", price: 210, isModular: true },
                    { name: "ASUS ROG Thor 1200W Platinum II", spec: "Platinum с OLED-дисплеем", price: 390, isModular: true }
                ]
            }
        ];

        let currentStep = 0;
        let selectedConfig = [];

        function update3DComponent(stepKey, option) {
            if (activeMeshes[stepKey]) {
                caseGroup.remove(activeMeshes[stepKey]);
            }

            let newMesh = null;
            if (stepKey === 'mb') newMesh = MeshBuilders.mb(option.type);
            else if (stepKey === 'cpu') newMesh = MeshBuilders.cpu(option.variant);
            else if (stepKey === 'cooler') newMesh = MeshBuilders.cooler(option.type);
            else if (stepKey === 'ram') newMesh = MeshBuilders.ram(option.count, option.isRGB);
            else if (stepKey === 'ssd') newMesh = MeshBuilders.ssd(option.hasHeatsink);
            else if (stepKey === 'gpu') newMesh = MeshBuilders.gpu(option.sizeCategory);
            else if (stepKey === 'psu') newMesh = MeshBuilders.psu(option.isModular);

            if (newMesh) {
                activeMeshes[stepKey] = newMesh;
                caseGroup.add(newMesh);

                newMesh.scale.set(0, 0, 0);
                let scale = 0;
                const anim = setInterval(() => {
                    scale += 0.1;
                    newMesh.scale.set(scale, scale, scale);
                    if (scale >= 1) clearInterval(anim);
                }, 15);
            }
        }

        function renderStep() {
            const step = steps[currentStep];
            document.getElementById('stepIndicator').innerText = `Шаг ${currentStep + 1} из ${steps.length}`;
            document.getElementById('stepTitle').innerText = step.title;

            const grid = document.getElementById('optionsGrid');
            grid.innerHTML = '';

            const currentTotal = selectedConfig.reduce((sum, item) => sum + (item ? item.price : 0), 0);

            step.options.forEach((opt) => {
                const card = document.createElement('div');
                card.className = 'option-card';
                
                // Проверка на превышение бюджета
                const isOverBudget = (currentTotal + opt.price) > INITIAL_BUDGET;

                card.innerHTML = `
                    <div class="option-info">
                        <div class="option-name">${opt.name}</div>
                        <div class="option-spec">${opt.spec}</div>
                    </div>
                    <div class="option-price" style="${isOverBudget ? 'color: var(--danger-color)' : ''}">$${opt.price}</div>
                `;

                if (!isOverBudget) {
                    card.onclick = () => selectOption(card, opt);
                } else {
                    card.style.opacity = '0.5';
                    card.style.cursor = 'not-allowed';
                    card.title = "Превышает доступный бюджет!";
                }

                grid.appendChild(card);
            });

            document.getElementById('nextBtn').disabled = true;
        }

        function selectOption(cardElement, option) {
            document.querySelectorAll('.option-card').forEach(c => c.classList.remove('selected'));
            cardElement.classList.add('selected');
            
            selectedConfig[currentStep] = option;
            updateTotalPrice();

            const stepKey = steps[currentStep].partKey;
            update3DComponent(stepKey, option);

            document.getElementById('nextBtn').disabled = false;
        }

        function updateTotalPrice() {
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
            document.getElementById('stepIndicator').innerText = "Сборка завершена!";
            document.getElementById('stepTitle').innerText = "🎉 ПК собран и готов к пуску!";
            document.getElementById('optionsGrid').innerHTML = `
                <div style="color: var(--text-sub); font-size: 0.9rem; line-height: 1.6;">
                    Поздравляем! Вы уложились в бюджет и собрали топовый компьютер.<br><br>
                    Нажмите кнопку ниже, чтобы подать питание, запустить кулеры и активировать RGB-подсветку!
                </div>
            `;

            const btn = document.getElementById('nextBtn');
            btn.innerText = "⚡ Запустить ПК";
            btn.className = "btn btn-power";
            btn.disabled = false;
            btn.onclick = powerOn;
        }

        function powerOn() {
            isSystemPoweredOn = true;
            let intensity = 0;
            const pwrAnim = setInterval(() => {
                intensity += 0.2;
                caseLight.intensity = intensity;
                if (intensity >= 4.0) clearInterval(pwrAnim);
            }, 30);

            let hue = 0;
            setInterval(() => {
                hue = (hue + 1) % 360;
                caseLight.color.setHSL(hue / 360, 1, 0.5);
            }, 20);
        }

        function animate() {
            requestAnimationFrame(animate);
            controls.update();
            
            // Вращение вентиляторов после запуска
            if (isSystemPoweredOn) {
                rotatingFans.forEach(fan => {
                    fan.rotation.y += 0.2;
                });
            }

            caseGroup.rotation.y += 0.0015;
            renderer.render(scene, camera);
        }

        window.addEventListener('resize', () => {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
        });

        renderStep();
        animate();
    </script>
</body>
</html>
