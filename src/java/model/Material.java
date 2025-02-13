/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author BAO CHAU
 */
public class Material {

    private int Mid;
    private String Mname;

    public Material(int Mid, String Mname) {
        this.Mid = Mid;
        this.Mname = Mname;
    }

    public int getMid() {
        return Mid;
    }

    public void setMid(int Mid) {
        this.Mid = Mid;
    }

    public String getMname() {
        return Mname;
    }

    public void setMname(String Mname) {
        this.Mname = Mname;
    }

}
