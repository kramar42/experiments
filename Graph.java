
public class Graph
{
	int [][] data;
	
	public Graph()
	{
		this(Dijkstra.GRAPH_SIZE);
	}
	
	public Graph(int size)
	{
		data = new int [size][size];
	}
	
	public void addEdge(int i, int j, int weight)
	{
		data[i][j] = data[j][i] = weight;
	}
	
	public void print()
	{
		for (int [] line : data)
		{
			for (int x : line)
			{
				System.out.print(x + "\t");
			}
			System.out.println();
		}
	}
}
