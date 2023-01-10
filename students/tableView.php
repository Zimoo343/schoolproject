<div class="tableView">
        <table class="student_table">
            <thead>
                <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Calificación</th>
                <th>Grupo</th>
                <th>Género</th>
                <th>Estado</th>
                <th>Pago</th>
                <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php 
                $search = strtolower($_REQUEST['search']);
                if(empty($search)) {
                    header("Location: /UNSC_database/students/students.php");
                } 
                $q = $search
                    ? "SELECT * FROM students WHERE student_id LIKE '%$search%' OR student_firstName LIKE '%$search%' OR student_lastName LIKE '%$search%'"
                    : "SELECT * FROM students_data";
                $student_result = $mysqli->query($q);
                while($row = mysqli_fetch_array($student_result)) { ?>
                    <tr>
                        <td><?php echo $row['student_id'] ?></td>
                        <td><?php echo $row['student_firstName'] ?></td>
                        <td><?php echo $row['student_lastName'] ?></td>
                        <td><?php echo $row['student_note'] < 0 ? "Sin nota" : $row['student_note'] ?></td>
                        <td><?php echo $row['group_code'] ?></td>
                        <td><?php echo $row['student_genre'] ?></td>
                        <td><?php echo $row['student_state'] ?></td>
                        <td><?php echo $row['student_payment'] ?></td>
                        <td>
                            <a href="edit.php?student_id=<?php echo $row['student_id']?>"><i class="fa-solid fa-pen-to-square"></i></a>
                            <a href="delete.php?student_id=<?php echo $row['student_id']?>"><i class="fa-solid fa-trash-can"></i></a>
                        </td>
                    </tr>
                <?php } ?>
            </tbody>
        </table>

    </div>

    <script>
        async function generatePDF() {
            document.getElementById("pdf").innerHTML;

            //Downloading
            var downloading = document.getElementById("body");
            var doc = new jsPDF('l', 'pt');

            await html2canvas(downloading, {
                //allowTaint: true,
                //useCORS: true,
                width: 530
            }).then((canvas) => {
                //Canvas (convert to PNG)
                doc.addImage(canvas.toDataURL("image/png"), 'PNG', 50, 50, 800, 400);
            })

            doc.save("ReporteStudents.pdf");

        }
    </script>