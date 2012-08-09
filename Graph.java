
public class Graph
{
	int [][] data;
	int [] weights;
	
	public Graph()
	{
		this(Dijkstra.GRAPH_SIZE);
	}
	
	public Graph(int size)
	{
		data = new int [size][size];
		weights = new int [size];
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
	
	public int [] findPath(int from, int to)
	{
		for (int i = 0; i < weights.length; ++i)
		{
			weights[i] = Dijkstra.INFINITY;
		}
		weights[from] = 0;
		
		for (int weight : weights)
			System.out.println(weight);
		return new int [5];
	}
}
