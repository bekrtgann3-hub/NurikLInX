<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3D Конфигуратор Сборки ПК Pro</title>
    <style>
        :root {
            --bg-color: #05070a;
            --panel-bg: rgba(10, 15, 26, 0.88);
            --accent-color: #2563eb;
            --accent-hover: #1d4ed8;
            --success-color: #10b981;
            --text-main: #f8fafc;
            --text-sub: #94a3b8;
            --border-color: #1e293b;
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
            max-width: 420px;
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

        .sidebar {
            position: absolute;
            right: 25px;
            top: 25px;
            bottom: 25px;
            width: 400px;
            background: var(--panel-bg);
            backdrop-filter: blur(16px);
            border-radius: 20px;
            border: 1px solid var(--border-color);
            padding: 20px;
            pointer-events: auto;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            box-shadow: 0 20px 50px rgba(0,0,0,0.8);
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
            max-height: calc(100vh - 280px);
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
            background: rgba(255, 255, 255, 0.03);
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
            background: rgba(255, 255, 255, 0.07);
            border-color: var(--accent-color);
        }

        .option-card.selected {
            border-color: var(--accent-color);
            background: rgba(37, 99, 235, 0.2);
            box-shadow: 0 0 15px rgba(37, 99, 235, 0.3);
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
            background: #1e293b;
            color: #475569;
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
            <h1>🖥️ 3D Конфигуратор ПК</h1>
            <p>Выбирайте компоненты и наблюдайте за изменением их вида</p>
        </div>

        <div class="controls-hint">
            🖱️ ЛКМ — вращение | ПКМ — смещение | Колесико — зум
        </div>

        <div class="sidebar">
            <div>
                <div class="step-indicator" id="stepIndicator">Шаг 1 из 7</div>
                <div class="step-title" id="stepTitle">Загрузка...</div>
                <div class="options-grid" id="optionsGrid"></div>
            </div>

            <div>
                <div class="price-summary">
                    <span>Итоговая цена:</span>
                    <span id="totalPrice" style="color: var(--success-color); font-size: 1.1rem;">$0</span>
                </div>
                <div class="footer-controls">
                    <button class="btn btn-next" id="nextBtn" disabled onclick="nextStep()">Далее ➔</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // --- 1. Сцена и Рендерер ---
        const container = document.getElementById('canvas-container');
        const scene = new THREE.Scene();
        scene.fog = new THREE.FogExp2(0x05070a, 0.05);

        const camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 0.1, 1000);
        camera.position.set(3.2, 1.8, 3.8);

        const renderer = new THREE.WebGLRenderer({ antialias: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(window.devicePixelRatio);
        renderer.shadowMap.enabled = true;
        renderer.shadowMap.type = THREE.PCFSoftShadowMap;
        container.appendChild(renderer.domElement);

        const controls = new THREE.OrbitControls(camera, renderer.domElement);
        controls.enableDamping = true;
        controls.dampingFactor = 0.05;

        // Освещение
        const ambientLight = new THREE.AmbientLight(0xffffff, 0.6);
        scene.add(ambientLight);

        const dirLight = new THREE.DirectionalLight(0xffffff, 1.2);
        dirLight.position.set(5, 8, 5);
        dirLight.castShadow = true;
        scene.add(dirLight);

        const caseLight = new THREE.PointLight(0x2563eb, 0, 4);
        caseLight.position.set(0, 0, 0);
        scene.add(caseLight);

        // --- 2. Генератор детализированного Черного Корпуса ---
        const caseGroup = new THREE.Group();
        scene.add(caseGroup);

        function createBlackCase() {
            const group = new THREE.Group();
            
            // Основной металлический корпус (Черная коробка)
            const bodyMat = new THREE.MeshStandardMaterial({ color: 0x090a0f, roughness: 0.4, metalness: 0.8 });
            
            // Задняя панель
            const backPanel = new THREE.Mesh(new THREE.BoxGeometry(0.05, 2.2, 2.0), bodyMat);
            backPanel.position.set(-0.8, 0, 0);
            
            // Верхняя крышка
            const topPanel = new THREE.Mesh(new THREE.BoxGeometry(1.6, 0.05, 2.0), bodyMat);
            topPanel.position.set(0, 1.1, 0);

            // Нижняя крышка и Кожух БП (PSU Shroud)
            const psuShroud = new THREE.Mesh(new THREE.BoxGeometry(1.6, 0.6, 2.0), bodyMat);
            psuShroud.position.set(0, -0.8, 0);

            // Каркасные стойки
            const frameGeo = new THREE.BoxGeometry(1.61, 2.21, 2.01);
            const frameMat = new THREE.MeshStandardMaterial({ color: 0x171923, wireframe: true });
            const frame = new THREE.Mesh(frameGeo, frameMat);

            // Темное закаленное стекло спереди
            const glassGeo = new THREE.BoxGeometry(1.6, 2.18, 0.02);
            const glassMat = new THREE.MeshPhysicalMaterial({
                color: 0x111111, transparent: true, opacity: 0.35,
                roughness: 0.1, transmission: 0.8, thickness: 0.5
            });
            const glass = new THREE.Mesh(glassGeo, glassMat);
            glass.position.set(0, 0, 1.0);

            group.add(backPanel, topPanel, psuShroud, frame, glass);
            return group;
        }
        caseGroup.add(createBlackCase());

        // Контейнер для динамически изменяемых компонентов
        const activeMeshes = {};

        // --- 3. Генераторы Уникального Дизайна Деталей ---
        const MeshBuilders = {
            mb: (type) => {
                const group = new THREE.Group();
                const pcbColor = type === 'white' ? 0xe2e8f0 : (type === 'taichi' ? 0x111827 : 0x0f172a);
                const pcb = new THREE.Mesh(
                    new THREE.BoxGeometry(0.08, 1.8, 1.5),
                    new THREE.MeshStandardMaterial({ color: pcbColor, roughness: 0.5 })
                );

                // Радиаторы VRM
                const heatsinkColor = type === 'taichi' ? 0xd97706 : 0x334155;
                const heatsink = new THREE.Mesh(
                    new THREE.BoxGeometry(0.12, 0.5, 0.4),
                    new THREE.MeshStandardMaterial({ color: heatsinkColor, metalness: 0.9, roughness: 0.2 })
                );
                heatsink.position.set(0.02, 0.55, -0.45);
                
                group.add(pcb, heatsink);
                group.position.set(-0.7, 0, 0);
                return group;
            },

            cpu: (variant) => {
                const group = new THREE.Group();
                const isAMD = variant.includes('AMD');
                // Текстура/Цвет крышки сокета
                const capColor = isAMD ? 0xb45309 : 0x94a3b8;
                const cpu = new THREE.Mesh(
                    new THREE.BoxGeometry(0.04, 0.35, 0.35),
                    new THREE.MeshStandardMaterial({ color: capColor, metalness: 0.9, roughness: 0.1 })
                );
                group.add(cpu);
                group.position.set(-0.62, 0.3, 0);
                return group;
            },

            cooler: (type) => {
                const group = new THREE.Group();
                if (type === 'air_small') {
                    // Базовый воздушный кулер
                    const rad = new THREE.Mesh(new THREE.BoxGeometry(0.25, 0.4, 0.4), new THREE.MeshStandardMaterial({ color: 0x94a3b8, metalness: 0.8 }));
                    const fan = new THREE.Mesh(new THREE.CylinderGeometry(0.18, 0.18, 0.05), new THREE.MeshStandardMaterial({ color: 0x1e293b }));
                    fan.rotation.z = Math.PI / 2;
                    fan.position.x = 0.15;
                    group.add(rad, fan);
                    group.position.set(-0.45, 0.3, 0);
                } else if (type === 'air_big') {
                    // Массивный двухбашенный кулер
                    const rad1 = new THREE.Mesh(new THREE.BoxGeometry(0.2, 0.5, 0.45), new THREE.MeshStandardMaterial({ color: 0x334155, metalness: 0.9 }));
                    const rad2 = rad1.clone();
                    rad2.position.x = 0.18;
                    group.add(rad1, rad2);
                    group.position.set(-0.45, 0.3, 0);
                } else if (type === 'water') {
                    // СВО (Водяное охлаждение)
                    const pump = new THREE.Mesh(new THREE.CylinderGeometry(0.18, 0.18, 0.1), new THREE.MeshStandardMaterial({ color: 0x2563eb, metalness: 0.5 }));
                    pump.rotation.z = Math.PI / 2;
                    pump.position.set(-0.58, 0.3, 0);
                    
                    const radiator = new THREE.Mesh(new THREE.BoxGeometry(1.2, 0.1, 0.4), new THREE.MeshStandardMaterial({ color: 0x0f172a }));
                    radiator.position.set(0, 1.0, 0);
                    
                    group.add(pump, radiator);
                }
                return group;
            },

            ram: (count, isRGB) => {
                const group = new THREE.Group();
                const color = isRGB ? 0xec4899 : 0x334155;
                for(let i = 0; i < count; i++) {
                    const stick = new THREE.Mesh(
                        new THREE.BoxGeometry(0.04, 0.45, 0.06),
                        new THREE.MeshStandardMaterial({ color: color, metalness: 0.6 })
                    );
                    stick.position.set(0, 0, i * 0.09);
                    group.add(stick);
                }
                group.position.set(-0.62, 0.3, 0.2);
                return group;
            },

            ssd: (hasHeatsink) => {
                const group = new THREE.Group();
                const h = hasHeatsink ? 0.06 : 0.02;
                const mat = hasHeatsink 
                    ? new THREE.MeshStandardMaterial({ color: 0x1e293b, metalness: 0.9 }) 
                    : new THREE.MeshStandardMaterial({ color: 0x15803d });
                
                const ssd = new THREE.Mesh(new THREE.BoxGeometry(0.03, h, 0.35), mat);
                group.add(ssd);
                group.position.set(-0.62, -0.2, 0.2);
                return group;
            },

            gpu: (sizeCategory) => {
                const group = new THREE.Group();
                let length = 0.7, height = 0.25, width = 0.8;
                let fanCount = 2;

                if (sizeCategory === 'large') {
                    length = 0.85; width = 1.2; fanCount = 3;
                } else if (sizeCategory === 'extreme') {
                    length = 0.95; height = 0.35; width = 1.4; fanCount = 3;
                }

                const body = new THREE.Mesh(
                    new THREE.BoxGeometry(length, height, width),
                    new THREE.MeshStandardMaterial({ color: 0x0f172a, metalness: 0.7, roughness: 0.2 })
                );
                group.add(body);

                // Генерация вентиляторов под размер карты
                const spacing = width / fanCount;
                for(let i = 0; i < fanCount; i++) {
                    const fan = new THREE.Mesh(
                        new THREE.CylinderGeometry(0.18, 0.18, 0.02),
                        new THREE.MeshStandardMaterial({ color: 0x334155 })
                    );
                    fan.position.set(0, -height/2, -width/2 + spacing/2 + i*spacing);
                    group.add(fan);
                }

                group.position.set(-0.2, -0.3, 0);
                return group;
            },

            psu: (isModular) => {
                const group = new THREE.Group();
                const psu = new THREE.Mesh(
                    new THREE.BoxGeometry(0.65, 0.55, 0.85),
                    new THREE.MeshStandardMaterial({ color: isModular ? 0x090a0f : 0x1e293b, metalness: 0.8 })
                );
                group.add(psu);
                group.position.set(-0.4, -0.75, -0.4);
                return group;
            }
        };

        // --- 4. Список Шагов и Вариантов ---
        const steps = [
            {
                title: "Материнская плата",
                partKey: "mb",
                options: [
                    { name: "GIGABYTE B760M DS3H", spec: "mATX / Строгий стиль", price: 140, type: "standard" },
                    { name: "ASUS ROG STRIX Z790-A", spec: "ATX / Белые радиаторы", price: 380, type: "white" },
                    { name: "ASRock X670E Taichi", spec: "E-ATX / Золотые элементы", price: 490, type: "taichi" }
                ]
            },
            {
                title: "Процессор (CPU)",
                partKey: "cpu",
                options: [
                    { name: "Intel Core i5-13400F", spec: "10 ядер / LGA1700", price: 200, variant: "Intel" },
                    { name: "AMD Ryzen 5 7600X", spec: "6 ядер / AM5 Сокет", price: 240, variant: "AMD" },
                    { name: "Intel Core i9-14900K", spec: "24 ядра / Топ мощность", price: 580, variant: "Intel" }
                ]
            },
            {
                title: "Система охлаждения",
                partKey: "cooler",
                options: [
                    { name: "DeepCool AG400", spec: "Компактная башня", price: 30, type: "air_small" },
                    { name: "be quiet! Dark Rock Pro 4", spec: "Массивный двойной кулер", price: 90, type: "air_big" },
                    { name: "NZXT Kraken 240 RGB", spec: "Водяное охлаждение (СВО)", price: 160, type: "water" }
                ]
            },
            {
                title: "Оперативная память (RAM)",
                partKey: "ram",
                options: [
                    { name: "Kingston Fury 16GB (2x8)", spec: "2 плашки / Черный радиатор", price: 65, count: 2, isRGB: false },
                    { name: "Corsair Vengeance RGB 32GB (2x16)", spec: "2 плашки / Подсветка", price: 145, count: 2, isRGB: true },
                    { name: "G.Skill Trident Z5 64GB (4x16)", spec: "4 плашки / RGB Экстрим", price: 260, count: 4, isRGB: true }
                ]
            },
            {
                title: "Накопитель (SSD M.2)",
                partKey: "ssd",
                options: [
                    { name: "Kingston NV2 1TB", spec: "Без радиатора", price: 65, hasHeatsink: false },
                    { name: "Samsung 990 PRO 2TB", spec: "С мощным радиатором", price: 185, hasHeatsink: true }
                ]
            },
            {
                title: "Видеокарта (GPU)",
                partKey: "gpu",
                options: [
                    { name: "NVIDIA RTX 4060 8GB", spec: "2 Кулера / Компактная", price: 300, sizeCategory: "small" },
                    { name: "NVIDIA RTX 4070 SUPER 12GB", spec: "3 Кулера / Средний размер", price: 600, sizeCategory: "large" },
                    { name: "NVIDIA RTX 4090 24GB", spec: "Огромная 3-слотовая плата", price: 1850, sizeCategory: "extreme" }
                ]
            },
            {
                title: "Блок питания (PSU)",
                partKey: "psu",
                options: [
                    { name: "DeepCool PK650D 650W", spec: "Стандартный корпус", price: 60, isModular: false },
                    { name: "Corsair RM750x 750W", spec: "Черный Модульный", price: 125, isModular: true }
                ]
            }
        ];

        let currentStep = 0;
        let selectedConfig = [];

        // --- 5. Обновление 3D Модели при выборе ---
        function update3DComponent(stepKey, option) {
            // Удаляем старый меш, если он уже был создан
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

                // Анимация масштабирования при установке
                newMesh.scale.set(0, 0, 0);
                let scale = 0;
                const anim = setInterval(() => {
                    scale += 0.1;
                    newMesh.scale.set(scale, scale, scale);
                    if (scale >= 1) clearInterval(anim);
                }, 15);
            }
        }

        // --- 6. Интерфейсная логика ---
        function renderStep() {
            const step = steps[currentStep];
            document.getElementById('stepIndicator').innerText = `Шаг ${currentStep + 1} из ${steps.length}`;
            document.getElementById('stepTitle').innerText = step.title;

            const grid = document.getElementById('optionsGrid');
            grid.innerHTML = '';

            step.options.forEach((opt) => {
                const card = document.createElement('div');
                card.className = 'option-card';
                card.innerHTML = `
                    <div class="option-info">
                        <div class="option-name">${opt.name}</div>
                        <div class="option-spec">${opt.spec}</div>
                    </div>
                    <div class="option-price">$${opt.price}</div>
                `;
                card.onclick = () => selectOption(card, opt);
                grid.appendChild(card);
            });

            document.getElementById('nextBtn').disabled = true;
        }

        function selectOption(cardElement, option) {
            document.querySelectorAll('.option-card').forEach(c => c.classList.remove('selected'));
            cardElement.classList.add('selected');
            
            selectedConfig[currentStep] = option;
            updateTotalPrice();

            // Динамически перерисовываем выбранный объект в 3D
            const stepKey = steps[currentStep].partKey;
            update3DComponent(stepKey, option);

            document.getElementById('nextBtn').disabled = false;
        }

        function updateTotalPrice() {
            const total = selectedConfig.reduce((sum, item) => sum + (item ? item.price : 0), 0);
            document.getElementById('totalPrice').innerText = `$${total}`;
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
            document.getElementById('stepIndicator').innerText = "Сборка готова!";
            document.getElementById('stepTitle').innerText = "🎉 ПК полностью укомплектован!";
            document.getElementById('optionsGrid').innerHTML = `
                <div style="color: var(--text-sub); font-size: 0.88rem; line-height: 1.6;">
                    Все выбранные компоненты смонтированы в корпус. Вы можете запустить компьютер и включить RGB-подсветку.
                </div>
            `;

            const btn = document.getElementById('nextBtn');
            btn.innerText = "⚡ Запустить ПК";
            btn.className = "btn btn-power";
            btn.disabled = false;
            btn.onclick = powerOn;
        }

        function powerOn() {
            let intensity = 0;
            const pwrAnim = setInterval(() => {
                intensity += 0.2;
                caseLight.intensity = intensity;
                if (intensity >= 3.5) clearInterval(pwrAnim);
            }, 40);

            let hue = 0;
            setInterval(() => {
                hue = (hue + 1) % 360;
                caseLight.color.setHSL(hue / 360, 1, 0.5);
            }, 25);

            alert("🚀 Компьютер запущен! Подсветка и вентиляторы активированы.");
        }

        // --- 7. Анимационный цикл THREE.JS ---
        function animate() {
            requestAnimationFrame(animate);
            controls.update();
            caseGroup.rotation.y += 0.002;
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
