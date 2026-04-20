package org.example.pj_thuexe_vinfast.modal;

public class Location {
    private int id;
    private String name;
    private String address;
    private String district;


    public Location() {
    }

    public Location(int id, String name, String address, String district) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.district = district;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }
}
