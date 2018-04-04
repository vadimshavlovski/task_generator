package taskgenerator.model;

import java.lang.reflect.Field;

public class Mapper {

    private Mapper() {
    }

    public static <T> void map(T oldObject, T patchObject) {
        try {
            Field[] privateFields = oldObject.getClass().getDeclaredFields();
            for (Field field : privateFields) {
                field.setAccessible(true);
                //check only reference types
                if(field.get(patchObject) == null){
                    field.set(patchObject, field.get(oldObject));
                }
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }
}
