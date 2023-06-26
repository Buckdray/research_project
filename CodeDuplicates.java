public class CodeDuplicates{

    private boolean isValid;

    public void method(){
        int a = 1;
        int b = 1;
        int c = a+b;
        int d = b+c;

    }

    private int add(int a, int b)
    {
        return a+b;
    }

    private int duplicatedAdd(int a, int b){
        return a+b;
    }

    public void method2(){
        int selectedNumber = 0;
        if(isValid){
            selectedNumber = 10;
        }else {
            selectedNumber = 20;
        }

        System.out.println("Selected number: "+ selectedNumber);

    }

    public int getSelectedNumber(){
        int selectedNumber = 0;
        if(isValid){
            selectedNumber = 10;
        }else {
            selectedNumber = 20;
        }
        return selectedNumber;
    }
}