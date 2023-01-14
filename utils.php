<?php

function outputMySQLToHTMLTable(
    mysqli $mysqli,
    string $query,
    array $actions = []
) {
    $headersMap = [
        "student_id" => "ID",
        "student_firstName" => "Nombre",
        "student_lastName" => "Apellido",
        "student_note" => "Calificacion",
        "student_genre" => "Género",
        "student_state" => "Estado",
        "student_payment" => "Pago",
        "group_name" => "Grupo",
        "group_code" => "Codigo de Grupo",
        "employee_id" => "ID",
        "employee_firstName" => "Nombre",
        "employee_lastName" => "Apellido",
        "employee_dept" => "Departamento",
        "employee_genre" => "Género",
        "employee_salary" => "Salario",
    ];

    $res = $mysqli->query($query);
    $data = $res->fetch_all(MYSQLI_ASSOC);
    
    echo '<table class="student_table">';
    // Display table header
    echo '<thead>';
    echo '<tr>';
    foreach ($res->fetch_fields() as $column) {
        echo '<th>'. htmlspecialchars($headersMap[$column->name]) .'</th>';
    }
    if (!empty($actions)) {
        echo '<th>Acciones</th>';
    }
    echo '</tr>';
    echo '</thead>';
    // If there is data then display each row
    if ($data) {
        foreach ($data as $row) {
            echo '<tr>';
            foreach ($row as $cell) {
                echo '<td>'.htmlspecialchars($cell).'</td>';
            }
            if (!empty($actions)) {
                echo '<td>';
                foreach ($actions as $a) {
                    echo '<a href="' . $a["page"] . '.php?' . $a["param"] . '=' . $row[$a["param"]] . '"><i class="' . $a["icon"] . '"></i></a>';
                }
                echo '</td>';
            }
            echo '</tr>';
        }
    } else {
        echo '<tr><td colspan="'.$res->field_count.'">No records in the table!</td></tr>';
    }
    echo '</table>';
}
