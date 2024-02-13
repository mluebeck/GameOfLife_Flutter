
class Cell {
    int x = -1;
    int y = -1;
    Cell(this.x, this.y);
    @override 
    bool operator ==(Object other) {
        Cell d = (other as Cell);
        return x==d.x && y==d.y;
    } 
    @override int get hashCode => x.hashCode + y.hashCode;
}