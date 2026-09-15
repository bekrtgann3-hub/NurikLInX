<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>University Project</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            background: #111;
            color: white;
            font-family: Arial, sans-serif;
            overflow: hidden;
        }

        /* Верхнее меню */
        .navbar {
            height: 70px;
            background: #181818;
            display: flex;
            align-items: center;
            padding: 0 25px;
            gap: 15px;
            border-bottom: 1px solid #333;
            position: relative;
            z-index: 1000;
        }

        .logo {
            font-size: 22px;
            font-weight: bold;
            margin-right: 30px;
        }

        .tab {
            padding: 12px 22px;
            border: none;
            border-radius: 8px;
            background: #292929;
            color: white;
            cursor: pointer;
            font-size: 15px;
        }

        .tab:hover {
            background: #3a3a3a;
        }

        .tab.active {
            background: #555;
        }

        /* Область страниц */
        .content {
            position: absolute;
            top: 70px;
            left: 0;
            right: 0;
            bottom: 0;
        }

        .page {
            width: 100%;
            height: 100%;
            display: none;
        }

        .page.active {
            display: block;
        }

        /* Hardware */
        #hardwarePage {
            background: #111;
        }

        #hardwareFrame {
            width: 100%;
            height: 100%;
            border: none;
            display: block;
        }

        /* Coffee */
        #coffeePage {
            background: #21150f;
        }

        #coffeeFrame {
            width: 100%;
            height: 100%;
            border: none;
            display: block;
        }
    </style>
</head>

<body>

    <div class="navbar">

        <div class="logo">
            MY PROJECT
        </div>

        <button class="tab active" onclick="openPage('hardwarePage', this)">
            💻 Hardware
        </button>

        <button class="tab" onclick="openPage('coffeePage', this)">
            ☕ 3D Coffee
        </button>

    </div>


    <div class="content">

        <!-- HARDWARE -->
        <div id="hardwarePage" class="page active">

            <iframe
                id="hardwareFrame"
                src="hardware.html">
            </iframe>

        </div>


        <!-- COFFEE -->
        <div id="coffeePage" class="page">

            <iframe
                id="coffeeFrame"
                src="coffee.html">
            </iframe>

        </div>

    </div>


    <script>

        function openPage(pageId, button) {

            // Скрываем все страницы
            document.querySelectorAll('.page').forEach(page => {
                page.classList.remove('active');
            });

            // Убираем active у кнопок
            document.querySelectorAll('.tab').forEach(tab => {
                tab.classList.remove('active');
            });

            // Показываем выбранную страницу
            document.getElementById(pageId).classList.add('active');

            // Активируем кнопку
            button.classList.add('active');
        }

    </script>

</body>
</html>
