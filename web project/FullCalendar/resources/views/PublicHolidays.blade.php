

    <!DOCTYPE html>
    <html>
    <head>
      <title>Public Holidays</title>
      @include('components.navbar')
                @include('components.sidebar')
                <meta name="csrf-token" content="{{ csrf_token() }}">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js" integrity="sha256-4iQZ6BVL4qNKlQ27TExEhBN1HFPvAvAMbFavKKosSWQ=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans&family=Nunito:wght@400;600;700&family=Open+Sans&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="{{ asset('vendor/bootstrap.min.css') }}">
        <link rel="stylesheet" href="{{ asset('css/tailwind.css') }}">
        <link rel="stylesheet" href="{{ asset('stisla/css/style.css') }}">
        <link rel="stylesheet" href="{{ asset('stisla/css/components.css') }}">
        <link rel="stylesheet" href="{{ asset('vendor/notyf/notyf.min.css') }}">
        <link rel="stylesheet" href="{{ asset('css/app.css') }}">

        <link rel="stylesheet" href="https://kit-free.fontawesome.com/releases/latest/css/free-v4-shims.min.css" media="all">
        <link rel="stylesheet" href="https://kit-free.fontawesome.com/releases/latest/css/free-v4-font-face.min.css" media="all">
        <link rel="stylesheet" href="https://kit-free.fontawesome.com/releases/latest/css/free.min.css" media="all">
        <link rel="stylesheet" type="text/css" href="/css/calendar.css" />
    <link rel="stylesheet" type="text/css" href="/css/custom.css" />
    </head>
    <body>
        <style type="text/css">
            .tg  {border-collapse:collapse;border-color:#9ABAD9;border-spacing:0;}
            .tg td{background-color:#EBF5FF;border-color:#9ABAD9;border-style:solid;border-width:1px;color:#444;
              font-family:Arial, sans-serif;font-size:14px;overflow:hidden;padding:10px 20px;word-break:normal;}
            .tg th{background-color:#409cff;border-color:#9ABAD9;border-style:solid;border-width:1px;color:#fff;
              font-family:Arial, sans-serif;font-size:14px;font-weight:normal;overflow:hidden;padding:10px 20px;word-break:normal;}
            .tg .tg-6lut{background-color:#FFF;border-color:inherit;color:#333;font-family:"Lucida Console", Monaco, monospace !important;;
              font-size:18px;text-align:left;vertical-align:top}
            .tg .tg-f7wl{background-color:#ffffff;color:#000000;font-family:"Lucida Console", Monaco, monospace !important;;font-size:18px;
              text-align:left;vertical-align:top}
            .tg .tg-g3gn{background-color:#ffffff;color:#6398ce;font-family:"Lucida Console", Monaco, monospace !important;;font-size:18px;
              text-align:left;vertical-align:top}
            .tg .tg-imj0{background-color:#57b2f3;border-color:inherit;font-family:"Comic Sans MS", cursive, sans-serif !important;;
              font-size:24px;font-weight:bold;text-align:center;vertical-align:top}
            .tg .tg-pciu{background-color:#57b2f3;border-color:inherit;font-family:"Comic Sans MS", cursive, sans-serif !important;;
              font-size:24px;font-weight:bold;text-align:left;vertical-align:top}
            .tg .tg-tuai{background-color:#FFF;border-color:inherit;color:#6398CE;font-family:"Lucida Console", Monaco, monospace !important;;
              font-size:18px;text-align:left;vertical-align:top}
            .tg .tg-88pj{background-color:#ffffff;font-family:"Lucida Console", Monaco, monospace !important;;font-size:18px;text-align:left;
              vertical-align:top}
            </style>
            <table class="tg" style="undefined;table-layout: fixed; width: 575px border:1px solid black;margin-left:auto;margin-right:auto;">
            <colgroup>
            <col style="width: 90px">
            <col style="width: 103px">
            <col style="width: 382px">
            </colgroup>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>

            <thead>
              <tr>
                <th class="tg-pciu">Day</th>
                <th class="tg-pciu">Date</th>
                <th class="tg-imj0">Holiday</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td class="tg-6lut">28 Jan</td>
                <td class="tg-6lut">Thu</td>
                <td class="tg-tuai">Thaipusam</td>
              </tr>
              <tr>
                <td class="tg-6lut">12 Feb</td>
                <td class="tg-6lut">Fri</td>
                <td class="tg-tuai">Chinese New Year</td>
              </tr>
              <tr>
                <td class="tg-6lut">13 Feb</td>
                <td class="tg-6lut">Sat</td>
                <td class="tg-tuai">Chinese New Year Holiday</td>
              </tr>
              <tr>
                <td class="tg-6lut">14 Feb</td>
                <td class="tg-6lut">Sun</td>
                <td class="tg-tuai">Chinese New Year Holiday</td>
              </tr>
              <tr>
                <td class="tg-6lut">23 Mar</td>
                <td class="tg-6lut">Tue</td>
                <td class="tg-tuai">Sultan of Johor's Birthday</td>
              </tr>
              <tr>
                <td class="tg-6lut">13 Apr</td>
                <td class="tg-6lut">Tue</td>
                <td class="tg-tuai">Awal Ramadan</td>
              </tr>
              <tr>
                <td class="tg-6lut">1 May</td>
                <td class="tg-6lut">Sat</td>
                <td class="tg-tuai">Labour Day</td>
              </tr>
              <tr>
                <td class="tg-6lut">13 May</td>
                <td class="tg-6lut">Thu</td>
                <td class="tg-tuai">Hari Raya Aidilfitri</td>
              </tr>
              <tr>
                <td class="tg-6lut">14 May</td>
                <td class="tg-6lut">Fri</td>
                <td class="tg-tuai">Hari Raya Aidilfitri Holiday</td>
              </tr>
              <tr>
                <td class="tg-6lut">16 May</td>
                <td class="tg-6lut">Sun</td>
                <td class="tg-tuai">Hari Raya Aidilfitri Holiday</td>
              </tr>
              <tr>
                <td class="tg-6lut">26 May</td>
                <td class="tg-6lut">Wed</td>
                <td class="tg-tuai">Wesak Day</td>
              </tr>
              <tr>
                <td class="tg-6lut">7 Jun</td>
                <td class="tg-6lut">Mon</td>
                <td class="tg-tuai">Agong's Birthday</td>
              </tr>
              <tr>
                <td class="tg-6lut">20 Jul</td>
                <td class="tg-6lut">Tue</td>
                <td class="tg-tuai">Hari Raya Haji</td>
              </tr>
              <tr>
                <td class="tg-6lut">10 Aug</td>
                <td class="tg-6lut">Tue</td>
                <td class="tg-tuai">Awal Muharram</td>
              </tr>
              <tr>
                <td class="tg-6lut">31 Aug</td>
                <td class="tg-6lut">Tue</td>
                <td class="tg-tuai">Merdeka Day</td>
              </tr>
              <tr>
                <td class="tg-6lut">13 Sep</td>
                <td class="tg-6lut">Mon</td>
                <td class="tg-tuai">Hari Hol Almarhum Sultan Iskandar</td>
              </tr>
              <tr>
                <td class="tg-6lut">16 Sep</td>
                <td class="tg-6lut">Thu</td>
                <td class="tg-tuai">Malaysia Day</td>
              </tr>
              <tr>
                <td class="tg-6lut">19 Oct</td>
                <td class="tg-6lut">Tue</td>
                <td class="tg-tuai">Prophet Muhammad's Birthday</td>
              </tr>
              <tr>
                <td class="tg-6lut">4 Nov</td>
                <td class="tg-6lut">Thu</td>
                <td class="tg-tuai">Deepavali</td>
              </tr>
              <tr>
                <td class="tg-88pj">25 Dec</td>
                <td class="tg-f7wl">Sat</td>
                <td class="tg-g3gn">Christmas Day</td>
              </tr>
            </tbody>
            </table>
            <br>
            <br>
            <br>
</body>
    </html>