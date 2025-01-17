package repositorio;
import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import modelo.DireccionFisica;





public interface DireccionFisicaRepository extends JpaRepository<DireccionFisica, Integer>{

        @Modifying
        @Transactional
        @Query(value = "INSERT INTO direccion_fisica (direccion,ciudad,deptartamento,codigo_postal) VALUES (bancAndes_seq.nextval, :direccion,:ciudad,:deptartamento,:codigo_postal)", nativeQuery = true)
        void insertarDireccionFisica(@Param("direccion") String direccion, @Param("ciudad") String ciudad, @Param("deptartamento") String deptartamento, @Param("codigo_postal") String codigo_postal);
              
}