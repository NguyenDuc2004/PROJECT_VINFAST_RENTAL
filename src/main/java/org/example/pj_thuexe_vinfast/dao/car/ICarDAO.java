package org.example.pj_thuexe_vinfast.dao.car;

import org.example.pj_thuexe_vinfast.modal.Car;

import java.util.List;

public interface ICarDAO {
    List<Car> filterSearchCars(String keyword, String status, String category);

    void insert(Car car);

    void delete(int id);

    Car getById(int id);

    boolean update(Car car);


}