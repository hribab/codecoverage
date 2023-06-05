using System;
using System.Collections.Generic;
using Algorithms.Search.AStar;
using Xunit;

namespace PriorityQueueTests
{
    public class PriorityQueueTests
    {
        // Test case 1: Enqueue a single item and verify the count and peek element
        [Fact]
        public void Enqueue_SingleItem_Count_Peek_Success()
        {
            // Arrange
            var priorityQueue = new PriorityQueue<int>();

            // Act
            priorityQueue.Enqueue(1);

            // Assert
            Assert.Equal(1, priorityQueue.Count);
            Assert.Equal(1, priorityQueue.Peek());
        }

        // Test case 2: Enqueue multiple items and verify count and peek element
        [Fact]
        public void Enqueue_MultipleItems_Count_Peek_Success()
        {
            // Arrange
            var priorityQueue = new PriorityQueue<int>();

            // Act
            priorityQueue.Enqueue(1);
            priorityQueue.Enqueue(2);
            priorityQueue.Enqueue(3);

            // Assert
            Assert.Equal(3, priorityQueue.Count);
            Assert.Equal(1, priorityQueue.Peek());
        }

        // Test case 3: Enqueue and dequeue multiple items
        [Fact]
        public void EnqueueDequeue_MultipleItems_Ordered_Success()
        {
            // Arrange
            var priorityQueue = new PriorityQueue<int>();

            // Act
            priorityQueue.Enqueue(2);
            priorityQueue.Enqueue(1);
            priorityQueue.Enqueue(3);

            var dequeue1 = priorityQueue.Dequeue();
            var dequeue2 = priorityQueue.Dequeue();
            var dequeue3 = priorityQueue.Dequeue();

            // Assert
            Assert.Equal(1, dequeue1);
            Assert.Equal(2, dequeue2);
            Assert.Equal(3, dequeue3);
        }

        // Test case 4: Enqueue and dequeue multiple items with reverse order
        [Fact]
        public void EnqueueDequeue_MultipleItems_ReverseOrdered_Success()
        {
            // Arrange
            var priorityQueue = new PriorityQueue<int>(isDescending: true);

            // Act
            priorityQueue.Enqueue(2);
            priorityQueue.Enqueue(1);
            priorityQueue.Enqueue(3);

            var dequeue1 = priorityQueue.Dequeue();
            var dequeue2 = priorityQueue.Dequeue();
            var dequeue3 = priorityQueue.Dequeue();

            // Assert
            Assert.Equal(3, dequeue1);
            Assert.Equal(2, dequeue2);
            Assert.Equal(1, dequeue3);
        }

        // Test case 5: Enqueue and dequeue multiple items of custom comparable object
        [Fact]
        public void EnqueueDequeue_MultipleItems_CustomObject_Success()
        {
            // Arrange
            var priorityQueue = new PriorityQueue<PriorityTestItem>();
            var item1 = new PriorityTestItem(2, "test1");
            var item2 = new PriorityTestItem(1, "test2");
            var item3 = new PriorityTestItem(3, "test3");

            // Act
            priorityQueue.Enqueue(item1);
            priorityQueue.Enqueue(item2);
            priorityQueue.Enqueue(item3);

            var dequeue1 = priorityQueue.Dequeue();
            var dequeue2 = priorityQueue.Dequeue();
            var dequeue3 = priorityQueue.Dequeue();

            // Assert
            Assert.Equal(item2, dequeue1);
            Assert.Equal(item1, dequeue2);
            Assert.Equal(item3, dequeue3);
        }
    }

    public class PriorityTestItem : IComparable<PriorityTestItem>
    {
        public int Priority { get; set; }
        public string Value { get; set; }

        public PriorityTestItem(int priority, string value)
        {
            Priority = priority;
            Value = value;
        }

        public int CompareTo(PriorityTestItem other)
        {
            return Priority.CompareTo(other.Priority);
        }
    }
}