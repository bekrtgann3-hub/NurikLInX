<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3D Конфигуратор Сборки ПК Pro</title>
    <style>
        :root {
            --bg-color: #080b12;
            --panel-bg: rgba(15, 23, 42, 0.88);
            --accent-color: #3b82f6;
            --accent-hover: #2563eb;
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
            background: rgba(59, 130, 246, 0.15);
            box-shadow: 0 0 15px rgba(59, 130, 246, 0.2);
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
            <p>Вращайте модель мышью для осмотра деталей</p>
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
        scene.fog = new THREE.FogExp2(0x080b12, 0.05);

        const camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 0.1, 1000);
        camera.position.set(3.2, 2.0, 3.8);

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
        const ambientLight = new THREE.AmbientLight(0xffffff, 0.7);
        scene.add(ambientLight);

        const dirLight = new THREE.DirectionalLight(0xffffff, 1.2);
        dirLight.position.set(5, 8, 5);
        dirLight.castShadow = true;
        scene.add(dirLight);

        const caseLight = new THREE.PointLight(0x3b82f6, 0, 4);
        caseLight.position.set(0, 0, 0);
        scene.add(caseLight);

        // --- 2. Генератор детализированных 3D-моделей ---
        const caseGroup = new THREE.Group();
        scene.add(caseGroup);

        const parts = {};

        // 1. Корпус (Каркас + Закаленное стекло)
        function createCase() {
            const group = new THREE.Group();
            // Металлический каркас
            const frameGeo = new THREE.BoxGeometry(1.6, 2.2, 2.0);
            const frameMat = new THREE.MeshStandardMaterial({ color: 0x111827, metalness: 0.8, roughness: 0.2 });
            const frame = new THREE.Mesh(frameGeo, frameMat);
            
            // Стекло
            const glassGeo = new THREE.BoxGeometry(1.62, 2.18, 1.98);
            const glassMat = new THREE.MeshPhysicalMaterial({
                color: 0xffffff, transparent: true, opacity: 0.25,
                roughness: 0.1, transmission: 0.9, thickness: 0.5
            });
            const glass = new THREE.Mesh(glassGeo, glassMat);

            group.add(frame, glass);
            return group;
        }
        caseGroup.add(createCase());

        // 2. Материнская плата (Плата + Радиаторы охлаждения)
        function createMotherboard() {
            const group = new THREE.Group();
            // Текстолит
            const pcb = new THREE.Mesh(
                new THREE.BoxGeometry(0.08, 1.8, 1.5),
                new THREE.MeshStandardMaterial({ color: 0x0f172a, roughness: 0.5 })
            );
            // Металлические радиаторы
            const heatsink = new THREE.Mesh(
                new THREE.BoxGeometry(0.12, 0.4, 0.4),
                new THREE.MeshStandardMaterial({ color: 0x334155, metalness: 0.9, roughness: 0.1 })
            );
            heatsink.position.set(0.02, 0.6, -0.4);
            group.add(pcb, heatsink);
            group.position.set(-0.7, 0, 0);
            return group;
        }
        parts.mb = createMotherboard();
        caseGroup.add(parts.mb);

        // Вспомогательная функция для сборных моделей
        function createPartMesh(builderFunc) {
            const meshGroup = builderFunc();
            meshGroup.visible = false;
            caseGroup.add(meshGroup);
            return meshGroup;
        }

        // 3. Процессор (Процессорный сокет + Крышка)
        parts.cpu = createPartMesh(() => {
            const group = new THREE.Group();
            const cpu = new THREE.Mesh(
                new THREE.BoxGeometry(0.04, 0.35, 0.35),
                new THREE.MeshStandardMaterial({ color: 0x94a3b8, metalness: 0.95, roughness: 0.1 })
            );
            group.add(cpu);
            group.position.set(-0.62, 0.3, 0);
            return group;
        });

        // 4. Охлаждение (Башенный кулер с вентилятором)
        parts.cooler = createPartMesh(() => {
            const group = new THREE.Group();
            // Радиатор
            const rad = new THREE.Mesh(
                new THREE.BoxGeometry(0.3, 0.5, 0.5),
                new THREE.MeshStandardMaterial({ color: 0xcbd5e1, metalness: 0.8 })
            );
            // Вентилятор
            const fan = new THREE.Mesh(
                new THREE.CylinderGeometry(0.22, 0.22, 0.05, 16),
                new THREE.MeshStandardMaterial({ color: 0x1e293b })
            );
            fan.rotation.z = Math.PI / 2;
            fan.position.x = 0.18;
            group.add(rad, fan);
            group.position.set(-0.45, 0.3, 0);
            return group;
        });

        // 5. ОЗУ (Планки с радиаторами)
        parts.ram = createPartMesh(() => {
            const group = new THREE.Group();
            for(let i = 0; i < 2; i++) {
                const stick = new THREE.Mesh(
                    new THREE.BoxGeometry(0.04, 0.45, 0.08),
                    new THREE.MeshStandardMaterial({ color: 0xef4444, metalness: 0.6 })
                );
                stick.position.set(0, 0, i * 0.12);
                group.add(stick);
            }
            group.position.set(-0.62, 0.3, 0.25);
            return group;
        });

        // 6. SSD M.2 (Плашка с радиатором)
        parts.ssd = createPartMesh(() => {
            const group = new THREE.Group();
            const ssd = new THREE.Mesh(
                new THREE.BoxGeometry(0.03, 0.08, 0.35),
                new THREE.MeshStandardMaterial({ color: 0xeab308, metalness: 0.5 })
            );
            group.add(ssd);
            group.position.set(-0.62, -0.2, 0.2);
            return group;
        });

        // 7. Видеокарта (Текстолит + Кожух + Вентиляторы)
        parts.gpu = createPartMesh(() => {
            const group = new THREE.Group();
            // Кожух
            const body = new THREE.Mesh(
                new THREE.BoxGeometry(0.8, 0.28, 1.1),
                new THREE.MeshStandardMaterial({ color: 0x0f172a, metalness: 0.5, roughness: 0.2 })
            );
            // Кулеры на GPU
            for(let i = -0.3; i <= 0.3; i += 0.6) {
                const fan = new THREE.Mesh(
                    new THREE.CylinderGeometry(0.2, 0.2, 0.02, 16),
                    new THREE.MeshStandardMaterial({ color: 0x334155 })
                );
                fan.position.set(0, -0.14, i);
                group.add(fan);
            }
            group.add(body);
            group.position.set(-0.2, -0.3, 0);
            return group;
        });

        // 8. Блок питания
        parts.psu = createPartMesh(() => {
            const group = new THREE.Group();
            const psu = new THREE.Mesh(
                new THREE.BoxGeometry(0.65, 0.55, 0.85),
                new THREE.MeshStandardMaterial({ color: 0x1e293b, metalness: 0.7 })
            );
            group.add(psu);
            group.position.set(-0.4, -0.75, -0.4);
            return group;
        });

        // --- 3. Расширенные шаги и варианты выбора ---
        const steps = [
            {
                title: "Материнская плата",
                partKey: "mb",
                options: [
                    { name: "GIGABYTE B760M DS3H", spec: "mATX / DDR5 / PCIe 4.0", price: 140 },
                    { name: "MSI MAG B650 TOMAHAWK", spec: "ATX / AM5 / Wi-Fi 6E", price: 220 },
                    { name: "ASUS ROG STRIX Z790-A", spec: "ATX / DDR5 / Топ разгон", price: 380 },
                    { name: "ASRock X670E Taichi", spec: "E-ATX / Флагман AM5", price: 490 }
                ]
            },
            {
                title: "Процессор (CPU)",
                partKey: "cpu",
                options: [
                    { name: "Intel Core i5-13400F", spec: "10 ядер / 16 потоков", price: 200 },
                    { name: "AMD Ryzen 5 7600X", spec: "6 ядер / 12 потоков", price: 240 },
                    { name: "Intel Core i7-14700K", spec: "20 ядер / 28 потоков", price: 410 },
                    { name: "AMD Ryzen 7 7800X3D", spec: "8 ядер / Лучший для игр", price: 450 },
                    { name: "Intel Core i9-14900K", spec: "24 ядра / 5.8 GHz", price: 580 }
                ]
            },
            {
                title: "Система охлаждения",
                partKey: "cooler",
                options: [
                    { name: "DeepCool AG400", spec: "Воздушное / TDP 220W", price: 30 },
                    { name: "be quiet! Dark Rock 4", spec: "Тихий башенный кулер", price: 75 },
                    { name: "NZXT Kraken 240 RGB", spec: "СВО Водяное 240мм", price: 150 },
                    { name: "ARCTIC Liquid Freezer III 360", spec: "СВО Флагман 360мм", price: 180 }
                ]
            },
            {
                title: "Оперативная память (RAM)",
                partKey: "ram",
                options: [
                    { name: "Kingston Fury 16GB (2x8)", spec: "DDR5 5200MHz", price: 65 },
                    { name: "G.Skill Ripjaws 32GB (2x16)", spec: "DDR5 6000MHz CL30", price: 115 },
                    { name: "Corsair Vengeance RGB 32GB", spec: "DDR5 6400MHz", price: 145 },
                    { name: "G.Skill Trident Z5 64GB (2x32)", spec: "DDR5 6400MHz", price: 240 }
                ]
            },
            {
                title: "Накопитель (SSD M.2)",
                partKey: "ssd",
                options: [
                    { name: "Kingston NV2 1TB", spec: "PCIe 4.0 / 3500 MB/s", price: 65 },
                    { name: "WD Black SN850X 1TB", spec: "PCIe 4.0 / 7300 MB/s", price: 105 },
                    { name: "Samsung 990 PRO 2TB", spec: "PCIe 4.0 / 7450 MB/s", price: 185 },
                    { name: "Crucial T700 2TB", spec: "PCIe 5.0 / 12400 MB/s!", price: 290 }
                ]
            },
            {
                title: "Видеокарта (GPU)",
                partKey: "gpu",
                options: [
                    { name: "NVIDIA RTX 4060 8GB", spec: "1080p Гейминг", price: 300 },
                    { name: "AMD Radeon RX 7700 XT 12GB", spec: "Отличный 1440p", price: 420 },
                    { name: "NVIDIA RTX 4070 SUPER 12GB", spec: "Топ 1440p / Ray Tracing", price: 600 },
                    { name: "NVIDIA RTX 4080 SUPER 16GB", spec: "Мощный 4K гейминг", price: 1000 },
                    { name: "NVIDIA RTX 4090 24GB", spec: "Абсолютный максимум", price: 1850 }
                ]
            },
            {
                title: "Блок питания (PSU)",
                partKey: "psu",
                options: [
                    { name: "DeepCool PK650D", spec: "650W / 80+ Bronze", price: 60 },
                    { name: "Corsair RM750x", spec: "750W / 80+ Gold Modular", price: 125 },
                    { name: "be quiet! Straight Power 850W", spec: "850W / 80+ Platinum", price: 175 },
                    { name: "ASUS ROG Thor 1000W", spec: "1000W Platinum / OLED экран", price: 330 }
                ]
            }
        ];

        let currentStep = 0;
        let selectedConfig = [];

        // --- 4. Интерфейсная логика ---
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
            
            document.getElementById('nextBtn').disabled = false;
        }

        function updateTotalPrice() {
            const total = selectedConfig.reduce((sum, item) => sum + (item ? item.price : 0), 0);
            document.getElementById('totalPrice').innerText = `$${total}`;
        }

        function nextStep() {
            const step = steps[currentStep];
            const mesh = parts[step.partKey];

            if(mesh) {
                mesh.visible = true;
                // Эффект плавного появления
                mesh.scale.set(0, 0, 0);
                let scale = 0;
                const anim = setInterval(() => {
                    scale += 0.1;
                    mesh.scale.set(scale, scale, scale);
                    if (scale >= 1) clearInterval(anim);
                }, 15);
            }

            currentStep++;

            if (currentStep < steps.length) {
                renderStep();
            } else {
                showFinal();
            }
        }

        function showFinal() {
            document.getElementById('stepIndicator').innerText = "Готово!";
            document.getElementById('stepTitle').innerText = "🎉 ПК собран и готов!";
            document.getElementById('optionsGrid').innerHTML = `
                <div style="color: var(--text-sub); font-size: 0.88rem; line-height: 1.6;">
                    Все выбранные компоненты протестированы на совместимость. Нажмите кнопку ниже для первого запуска.
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

            alert("🚀 ПК запущен! Система охлаждения и подсветка функционируют штатно.");
        }

        // --- 5. Анимационный цикл ---
        function animate() {
            requestAnimationFrame(animate);
            controls.update();
            caseGroup.rotation.y += 0.002; // Плавное автовращение
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
